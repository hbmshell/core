/*
O sistema de logs é configurado através da classe de configuração VConfig

*/
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton() // Obtém as configurações do sistema

    CONFIG LOG LEVEL INFO
    FErase( oCfg:getLogName() )
    ? "LOG LEVEL : " , oCfg:getLogLevel()
    LOG "Hello World" INFO

/*
    Simulação de erro
*/    
    SET COLOR TO "R+/B"
    ? "------------------------------------------------------------------------------"
    ? "oO :;"
    ? "Generating error... (After error, see error log AAAAMMDD.log)"    
    ? "                                                Windows : execute type.exe " + oCfg:GetLogName()
    ? "                                                *NIX    : execute cat " + oCfg:GetLogName()    
    ? "------------------------------------------------------------------------------"
    ? 1 + "NUMERIC + STRING = ERRO"

    RETURN
