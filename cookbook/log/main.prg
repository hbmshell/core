#include "fileio.ch"
FUNCTION hb_Main()

     LOCAL cMessage := "Save in log " , x
     FErase("mylog.log" )
     FOR x := 1 TO 100
          MyLog( cMessage + " -> " + STR(x) )
     NEXT
     ? "Log content"
     ? hb_MemoRead( "mylog.log" )

RETURN NIL

FUNCTION MyLog( cTexto  )

     LOCAL nHandle
     LOCAL cName := "mylog.log"


     IF .NOT. FILE( cName )
          nHandle := FCREATE( cName )
     ELSE
          nHandle := FOPEN( cName , FO_READWRITE + FO_SHARED )
     ENDIF 

     FSEEK( nHandle  ,0,2)

     FWRITE( nHandle , cTexto + HB_EOL() )
     FCLOSE( nHandle )

     RETURN NIL