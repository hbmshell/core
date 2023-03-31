#include "vbase.ch"

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent

    CLS
    CONFIG LOG LEVEL ERROR
    
    LOG TEXT "This file will be saved in log." TAG "MY TAG ID"
    ?
    ?
    ? "Type any key to continue."
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


