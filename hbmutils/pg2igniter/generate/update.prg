#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "vbase.ch"
request SQLMIX , SDDPG
PROCEDURE Hbm_Gen( ... )
    MODULE SHELL

    IF hb_PValue( 1 ) == "--help"
        Hbm_Help()
    ENDIF    
    CONFIG LOG LEVEL ERROR // ERROR , FATAL , WARNING
    CONFIG LOG DISPLAY ON // OFF

    ? "Iniciando"
    FUpdateCMD(  __DATABASE_IP , __DATABASE_USR, __DATABASE_PWD, __DATABASE_NAME, __DATABASE_PORT )
    ? "Finalizando"
    
RETURN 
//---------------------------------------------------------
STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "" )
    ? "Objetivo : Atualizar a base de dados local com os metadados do banco"
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN

