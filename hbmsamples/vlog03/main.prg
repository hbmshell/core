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
    ? "Erasing file now"
    Ferase( oCfg:GetLogName() )


    RETURN


