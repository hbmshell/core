#include "vbase.ch"

PROCEDURE MAIN

    LOCAL cContent
    LOCAL oCfg := ConfigSingleton()

    CLS
    CONFIG LOG LEVEL ERROR
    
    LOG TEXT "This file will be saved in log." TO FILE mylog.log
    ?
    ?
    ? "Type any key see mylog.log"
    Inkey(0)
    cContent := MemoRead( "mylog.log" )
    ? "-------------------------------------"
    ? "- Content (Log file generated : " + "mylog.log" + ")"
    ? "-------------------------------------"
    ? cContent
    ?
    ? "Erasing file now"
    Ferase( "mylog.log" )
    Ferase( oCfg:GetLogName() )


    RETURN


