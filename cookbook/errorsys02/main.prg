//http://www.pctoledo.com.br/forum/filebase.php?d=1&id=231&searchword=Errorsys&what=s&page=1
*------------------------------------------------------------------------------*
PROCEDURE Main
*------------------------------------------------------------------------------*

	ErrorBlock( { | oError | MyDefError( oError ) } )
    
    dbCreate( "dbf01" , {{ "DB01" , "C" , 12 , 0 }} )
    dbCreate( "dbf02" , {{ "DB02" , "C" , 12 , 0 }} )
    USE DBF01
    USE DBF02 new
    
    ? "ERROR " + 12121212


RETURN

#include "error.ch"


// put messages to STDERR
#command ? <list,...>   =>  ?? Chr(13) + Chr(10) ; ?? <list>
#command ?? <list,...>  =>  OutErr(<list>)


// used below
#define NTRIM(n)		( LTrim(Str(n)) )




/***
*	MyDefError()
*/
static func MyDefError(e)
local i, cMessage, aOptions, nChoice



	// by default, division by zero yields zero
	if ( e:genCode == EG_ZERODIV )
		return (0)
	end


	// for network open error, set NETERR() and subsystem default
	if ( e:genCode == EG_OPEN .and. e:osCode == 32 .and. e:canDefault )

		NetErr(.t.)
		return (.f.)									// NOTE

	end


	// for lock error during APPEND BLANK, set NETERR() and subsystem default
	if ( e:genCode == EG_APPENDLOCK .and. e:canDefault )

		NetErr(.t.)
		return (.f.)									// NOTE

	end



	// build error message
	cMessage := ErrorMessage(e)


	// build options array
	// aOptions := {"Break", "Quit"}
	aOptions := {"Quit"}

	if (e:canRetry)
		AAdd(aOptions, "Retry")
	end

	if (e:canDefault)
		AAdd(aOptions, "Default")
	end


	// put up alert box
	nChoice := 0
	while ( nChoice == 0 )

		if ( Empty(e:osCode) )
			nChoice := Alert( cMessage, aOptions )

		else
			nChoice := Alert( cMessage + ;
							";(DOS Error " + NTRIM(e:osCode) + ")", ;
							aOptions )
		end


		if ( nChoice == NIL )
			exit
		end

	end


	if ( !Empty(nChoice) )

		// do as instructed
		if ( aOptions[nChoice] == "Break" )
			Break(e)

		elseif ( aOptions[nChoice] == "Retry" )
			return (.t.)

		elseif ( aOptions[nChoice] == "Default" )
			return (.f.)

		end

	end


	// display message and traceback
	if ( !Empty(e:osCode) )
		cMessage += " (DOS Error " + NTRIM(e:osCode) + ") "
	end

	? cMessage
    
	i := 2
	while ( !Empty(ProcName(i)) )
		? "Called from", Trim(ProcName(i)) + ;
			"(" + NTRIM(ProcLine(i)) + ")  "

		i++
	end


	// give up
	ErrorLevel(1)
    // Show error customized
    ShowError( e  )
	QUIT

return (.f.)




/***
*	ErrorMessage()
*/
static func ErrorMessage(e)
local cMessage


	// start error message
	cMessage := if( e:severity > ES_WARNING, "Error ", "Warning " )


	// add subsystem name if available
	if ( ValType(e:subsystem) == "C" )
		cMessage += e:subsystem()
	else
		cMessage += "???"
	end


	// add subsystem's error code if available
	if ( ValType(e:subCode) == "N" )
		cMessage += ("/" + NTRIM(e:subCode))
	else
		cMessage += "/???"
	end


	// add error description if available
	if ( ValType(e:description) == "C" )
		cMessage += ("  " + e:description)
	end


	// add either filename or operation
	if ( !Empty(e:filename) )
		cMessage += (": " + e:filename)

	elseif ( !Empty(e:operation) )
		cMessage += (": " + e:operation)

	end


return (cMessage)

/*
ShowError
*/
#define CRLF hb_eol()
*******************************************
Function ShowError ( oError  )
********************************************
   LOCAL i, cTelaErro, cMsg_e
   LOCAL x_body_erro := ""
   LOCAL cArq_Log_Erro:="myerror.log"

   SETCANCEL(.F.)
   SET CURSOR OFF
   SET DEVICE TO SCREEN
   Tone(1000)
   
   x_body_erro:=""+CRLF
   x_body_erro+=" "+ErrorMessage(oError)+CRLF
   x_body_erro+=""+CRLF
   x_body_erro+=" Date.................: " + DToC( Date() )+"  Time: " + Time()+CRLF
   x_body_erro+=" Application Name.....: " + hb_cmdargargv()+CRLF
   x_body_erro+=" Current Workstation..: " + NetName()+CRLF
   x_body_erro+=" Operating System.....: " + OS()+CRLF
   x_body_erro+=" Error................: " + ErrorMessage(oError)+CRLF
   x_body_erro+=" File.................: " + oError:filename()+CRLF
   x_body_erro+=" DOS error code.......: " + hb_valtoexp( oError:oscode() )+CRLF
   x_body_erro+=""+CRLF
   x_body_erro+=" Memory for character..: " + ALLTRIM(STR(MEMORY(0))) + " for Block: " + ALLTRIM(STR(MEMORY(1)))+" for RUN: " + ALLTRIM(STR(MEMORY(2)))+CRLF
   x_body_erro+=""+CRLF
   IF .Not. Empty(ALIAS())
     x_body_erro+=" Database open........: " + ALIAS() + " Index Order: "+INDEXKEY(INDEXORD())+CRLF+""+CRLF
   ENDIF
   x_body_erro+=" Arguments: "+CRLF+""+CRLF
   IF VALTYPE(oError:args) == "A"
     x_body_erro+=" Array: "+ LTRIM(STR(LEN(oError:args)))+" Elements "+CRLF
     i := 1
     DO WHIL i < 4
       x_body_erro+=" Elemen[" + STR(i,2) + "]......: = Type: "+Valtype(oError:args[i])+" Val: "+hb_CStr(oError:args[i])+CRLF
       IF i == LEN(oError:args)
         EXIT
       ENDIF
       i++
     ENDDO
   ELSE
     x_body_erro+=" "+hb_CStr(oError:args)+CRLF+""+CRLF
   ENDIF
   x_body_erro+=" Trace for Erro:"+CRLF
   x_body_erro+=" ----------------"+CRLF

   i := 3
   while ( !Empty(ProcName(i)) )
     x_body_erro+=" Called from: " + Trim(ProcName(i)) + "(" + ALLTRIM(STR(ProcLine(i))) + ") - "+Subs(ProcFile(i),RAT("/",ProcFile(i))+1)+CRLF
     i++
   end

   cCod_erro:=RTRIM(oError:subSystem)+'/'+LTRIM(STR(oError:subCode))
   if left(cCod_erro,1)=='/'
     cCod_erro:=SUBS(cCod_erro,2)
   endif
    alert( StrTran( x_body_erro , CRLF , ";" ) )

     nHandle := FCreate( cArq_Log_Erro, 0 )
     IF nHandle < 3
       nHandle := FCreate( cArq_Log_Erro, 0 )
     ENDIF

     IF nHandle < 3
     ELSE
       FWrite( nHandle, x_body_erro )
     ENDIF
     FClose( nHandle )

   SETCANCEL(.T.)
   SET CURSOR ON

   UnloadAllDll()

   dbcloseall()

//   ExitProcess(0)

Return Nil

