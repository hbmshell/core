#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "dbstruct.ch"
PROCEDURE Hbm_Gen( ... )
    MODULE SHELL
    LOCAL hParams , cPrintParams
    LOCAL oObj
    LOCAL field
    
    SHELL ADD PARAM "--dbf" TITLE "Nome do arquivo" MANDATORY REQUIRE VALUE
    SHELL PRINT HELP TO cPrintParams
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF
    SHELL GET PARAMS TO hParams

    IF .NOT. FILE( IIF( EMPTY( hb_FNameExt(hParams["--dbf"])),; 
                                        hParams["--dbf"] + ".dbf" , hParams["--dbf"] )  )
        SHELL ERROR "O arquivo " + hParams["--dbf"] + " não foi encontrado" ERRORCODE 100
    ENDIF
    USE ( hParams["--dbf"] ) SHARED
    FOR EACH field IN dbStruct()
        ? PADR( field[ DBS_NAME ] , 20 ), field[ DBS_TYPE ], field[ DBS_LEN ] , field[ DBS_DEC ]
    NEXT


    
RETURN 
//---------------------------------------------------------
STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "" )
    ? "Objetivo : Exibe a estrutura de um arquivo (.dbf)"
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN

