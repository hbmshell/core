/*
O sistema de logs é configurado através da classe de configuração VConfig

*/
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton() // Obtém as configurações do sistema

    CONFIG LOG LEVEL INFO
    FErase( "temp" + hb_ps() + oCfg:getLogName() )
    MakeDir("temp")
    oCfg:setLogPath("temp")
    ? "LOG LEVEL : " , oCfg:getLogLevel()
    LOG "Hello World" INFO
    ? "See file in " + oCfg:getLogPath() + hb_ps() + oCfg:getLogName()

    RETURN
