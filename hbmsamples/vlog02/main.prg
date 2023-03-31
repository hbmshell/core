#include "vbase.ch"

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent
    LOCAL cMessage

    CONFIG LOG LEVEL INFO
    LOG "Hello World" INFO 
    ? "Type any key to see log content."
    Inkey(0)
    cContent := MemoRead( oCfg:GetLogName() )
    ? "-------------------------------------"
    ? "- Content (Log file generated : " + oCfg:GetLogName() + ")"
    ? "-------------------------------------"
    ? cContent
    ?
    ? "Erasing file now"
    Ferase( oCfg:GetLogName() )


    RETURN


