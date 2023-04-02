#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "vbase.ch"
PROCEDURE Hbm_GenListaFK( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cSelectSQL 
    LOCAL oObj
    LOCAL cNomeRot 
    LOCAL cJson,hJson,cParam,cReturnValue // Chave FK
    LOCAL oCfg := VConfigMeta():New()
    LOCAL oSelect, cAuxMandatory      
    LOCAL oTable


    SHELL ADD PARAM "--table" TITLE "Nome da tabela" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    SHELL ADD PARAM "--field" TITLE "Nome do campo" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "--debug" TITLE "Ativa o modo de depuração (Gera arquivo de log com a data de hoje)"
    
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 
    IF hParams["--debug"]
        CONFIG LOG LEVEL INFO // ERROR , FATAL , WARNING
        CONFIG LOG DISPLAY ON // OFF
   ENDIF

    IF .NOT. oCfg:Init( hParams["--table"] ) // <----------- Inicializa os dados com a leitura do arquivo
        SHELL ERROR oCfg:GetLastMessage() ERRORCODE 102
    ENDIF    
    
    IF oCfg:HasFieldInTableBrw( hParams["--field"] ) 
        IF oCfg:getField( hParams["--table"] , hParams["--field"] , "Fk" )
        ELSE
            SHELL ERROR "gen_lista_fk.prg: O par " + hParams["--table"] + "." + hParams["--field"] + " não corresponde a uma chave estrangeira" ERRORCODE 101        
        ENDIF    
    ELSE
        SHELL ERROR "gen_lista_fk.prg: O par " + hParams["--table"] + "." + hParams["--field"] + " não foi encontrado no dicionário" ERRORCODE 100
    ENDIF   

    //---------------------------------------------------------------------------------------------------------------
    /* Iniciando o objeto gerador de código */
    cNomeRot := "fk_" + hParams["--table"] + "_" + hParams["--field"] 
    oObj := VCodePrg():New( cNomeRot + ".prg" )
    oObj:SetIniBlock( "@" )
    oObj:SetEndBlock( "@@" )
    oObj:SetAutomatic( "Auto" )

    oObj:WriteLN("#!/usr/local/bin/hbmediator/hbmshell ")
    oObj:WriteLN("-q0")
    oObj:WriteLN("-n")

    /* Bloco inicial */
    oObj:IniBlock( "include")
    oObj:WriteLN( "#include 'cmdterminal.ch'" )
    oObj:WriteLN( "#include 'vbase.ch'" )
    oObj:WriteLN( "#include 'dcufc.ch'")
    oObj:EndBlock()

    oObj:IniBlock( "init")
    oObj:WriteLN( "PROCEDURE " + cNomeRot + "( ... )" )
    oObj:WriteLN( "    MODULE SHELL" )
    oObj:WriteLN( "    LOCAL hParams , cPrintParams" )
    oObj:WriteLN( "    LOCAL cSQL, oObj, aReturn" )
    oObj:WriteLN( "    LOCAL hWhere := {=>}, cWhere" )
    oObj:WriteLN( "    LOCAL aRet := {}" )
    oObj:EndBlock()

    oObj:IniBlock( "loglevel")
    oObj:WriteLN( '    //CONFIG LOG LEVEL INFO // ERROR , FATAL , WARNING' )
    oObj:WriteLN( '    //CONFIG LOG DISPLAY ON // OFF' )
    oObj:EndBlock()

    oObj:IniBlock( "where_param")
    oObj:WriteLN( '    //SHELL ADD PARAM "--field" TITLE "Fieldname" REQUIRE VALUE' )
    oObj:EndBlock()

    oObj:IniBlock( "shell")
    oObj:WriteLN( '    SHELL ADD PARAM "--limit" TITLE "Quantidade de registros por página" DEFAULT "100"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--json" TITLE "Retorno no formato JSON"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--pkvalue" TITLE "Busca pelo código" REQUIRE VALUE')

    oObj:WriteLN( '' )
    oObj:WriteLN( '    SHELL PRINT HELP TO cPrintParams' )    
    oObj:WriteLN( '    IF hb_PValue(1) == "--help"' )
    oObj:WriteLN( '        Hbm_Help( cPrintParams )' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    SHELL GET PARAMS TO hParams')
    oObj:WriteLN( '    SHELL SET MESSAGE JSON hParams["--json"]')    
    oObj:EndBlock()

    oObj:IniBlock( "connect")
    oObj:WriteLN( '    DATABASE oObj' )
    oObj:WriteLN( '    oObj:Connect()' )
    oObj:WriteLN( '    IF oObj:Open()' )
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR CONNECT_ERROR_MESSAGE ERRORCODE 103' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    ' )
    oObj:EndBlock()

    cSelectSQL := "select " + oCfg:getField( hParams["--table"], hParams["--field"] , "Field_Ref" ) 
    

    cReturnValue := oCfg:getField( hParams["--table"], hParams["--field"] , "Display_Ref" ) 
    IF EMPTY( cReturnValue )
        SHELL ERROR "Campo de retorno não definido. Verifique em config.json. Tabela: " + ;
            hParams["--table"] + " / Campo : " + hParams["--field"] ERRORCODE 105
    ENDIF    
    cSelectSQL += ("," + cReturnValue)
    cSelectSQL += " from " +  oCfg:getField( hParams["--table"], hParams["--field"] , "Table_Ref" )   

    oObj:IniBlock( "params")
    oObj:WriteLN( '    oObj:SetLimit( VAL( hParams["--limit"] ) )' )
    oObj:WriteLN( '    TEXT TO VAR cSQL' )
    oObj:WriteLN( '         ' + cSelectSQL )
    oObj:WriteLN( '    ENDTEXT' )
    oObj:EndBlock()

    oObj:IniBlock( "pkvalue")
    oObj:WriteLN( '    IF EMPTY( hParams["--pkvalue"] )')
    oObj:WriteLN( '    ELSE')
    oObj:WriteLN( e"        cSQL += \" WHERE " + hParams["--field"] + e" = '%s'\"")
    oObj:WriteLN( '        cSQL := hb_StrFormat( cSQL , hParams["--pkvalue"] )')
    oObj:WriteLN( '    ENDIF')
    oObj:WriteLN( '    cSQL += " Order by ' + cReturnValue + '"')
    oObj:EndBlock()
    

    oObj:IniBlock( "exec")
    oObj:WriteLN( '    oObj:SetQuery( cSQL )' )
    oObj:WriteLN( '    IF oObj:ExecuteQueryToDBF("fk")')
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()')
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    IF .NOT. EMPTY( hParams["--pkvalue"] )')
    oObj:WriteLN( '        SHELL MESSAGE IIF( FieldGet( 2 )==NIL, "", FieldGet( 2 ))')
    oObj:WriteLN( '    ELSE')        
    oObj:WriteLN( '        IF hParams["--json"]')
    oObj:WriteLN( '            AADD( aRet , { "" => "Em Branco" } )')        
    oObj:WriteLN( '            DO WHILE .NOT. EOF()')
    oObj:WriteLN( '                AADD( aRet , { FieldGet( 1 ) => FieldGet( 2 ) } )')
    oObj:WriteLN( '                SKIP')
    oObj:WriteLN( '            ENDDO')  
    oObj:WriteLN( '            SHELL MESSAGE aRet') 
    oObj:WriteLN( '        ELSE')
    oObj:WriteLN( '            SHELL MESSAGE Vlj_CMDLoop()')
    oObj:WriteLN( '        ENDIF')
    oObj:WriteLN( '    ENDIF')
    oObj:WriteLN( 'RETURN') 
    oObj:EndBlock()

    oObj:IniBlock( "help")
    oObj:WriteLN( 'STATIC PROCEDURE Hbm_Help( cPrintParams )')
    oObj:WriteLN( '    hb_Default( @cPrintParams , "")' )
    oObj:WriteLN( '    ? "Objetivo : "')
    oObj:WriteLN( '    ?' )
    oObj:WriteLN( '    ? "Parâmetros"' )
    oObj:WriteLN( '    ? "[--help]    Help"' )
    oObj:WriteLN( '    IF .NOT. EMPTY( cPrintParams )' )
    oObj:WriteLN( '        ? cPrintParams' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    QUIT' )
    oObj:WriteLN( "RETURN" )
    oObj:EndBlock()
#ifndef __PLATFORM__WINDOWS
    RUN ( "chmod 766 "  +  cNomeRot + ".prg" )
#endif
    // Fim
RETURN    

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objetivo :  Gerar o código fonte do grid referente a view."
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN
