/*
O sistema de logs é configurado através da classe de configuração VConfig

*/
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton() // Obtém as configurações do sistema

    CONFIG LOG LEVEL INFO
    FileDelete( "temp" + hb_ps() + "*.log" )
    MakeDir("temp")
    oCfg:setLogPath("temp")
    ? "LOG LEVEL : " , oCfg:getLogLevel()
    LOG "Hello World" INFO
    ? "File generated in " + oCfg:getLogPath() + hb_ps() + oCfg:getLogName()
    ?
    ?
    ? "Type any key to continue."
    Inkey(0)
    cContent := MemoRead( oCfg:getLogPath() + hb_ps() + oCfg:GetLogName() )
    ? "-------------------------------------"
    ? "- Content (Log file generated : " + oCfg:GetLogName() + ")"
    ? "-------------------------------------"
    ? cContent
    ?
    ? "Erasing file now"
    Ferase( oCfg:getLogPath() + hb_ps() + oCfg:GetLogName() )
    if DIRREMOVE( "temp" ) == 0
        ? "Remove of directory", "temp", "was successfull"
    endif


    RETURN
