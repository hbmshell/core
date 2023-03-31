#include "vbase.ch"
/*
gerando uma mensagem com código de erro (cláusula CODE do comando LOG)
*/
PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent

    CLS
    CONFIG LOG LEVEL INFO 
    
    LOG "Hello world" INFO CODE 123456
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


