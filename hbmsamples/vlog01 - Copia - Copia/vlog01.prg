/*
O sistema de logs é configurado através da classe de configuração VConfig

*/

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton() // Obtém as configurações do sistema
/*

    A propriedade getLogLevel() informa o nível de log 
    conforme as definições abaixo :

    #define CONFIG_FATAL 1
    #define CONFIG_ERROR 2
    #define CONFIG_WARNING 3
    #define CONFIG_INFO 4

    O valor default é CONFIG_FATAL

*/    

    ? "LOG LEVEL : " , oCfg:getLogLevel()

/*

    A propriedade getLogName() informa o nome do arquivo de LOG
    
    O valor default é ANO + MES + DIA, por exemplo :

    20200320.log corresponde ao log do dia 20 de março de 2020.

*/    

    ? "LOG NAME  : " , oCfg:getLogName()

    RETURN
