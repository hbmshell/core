#include "vbase.ch"

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent

    CLS
    CONFIG LOG LEVEL INFO
    CONFIG LOG DISPLAY ON
    LOG "This information will be showed in screen" WARNING
    CONFIG LOG DISPLAY OFF
    LOG "This information is showed only in log. Not in screen" ERROR
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


