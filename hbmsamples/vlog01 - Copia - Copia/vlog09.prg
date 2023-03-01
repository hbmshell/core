#include "vbase.ch"

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent

    CLS
    CONFIG LOG LEVEL INFO
    
    LOG "This file will be saved in log, but not in group process" INFO

    LOG GROUP "Init process"
    LOG "STEP 01" INFO
    // My Code Process 01 
    // ...
    // ...
    // ...
    LOG "STEP 02" INFO
    // My Code Process 02
    // ...
    // ...
    // ...
    LOG GROUP END
    LOG "This file will be saved in log, but not in group process" INFO
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


