#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "dbstruct.ch"
PROCEDURE Hbm_ListTablesByDict( ... )
    MODULE SHELL
    LOCAL hParams , cPrintParams
    LOCAL oObj
    LOCAL field

    /*
    SHELL ADD PARAM "--table" TITLE "Nome da tabela" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "--count-fields" TITLE "Quantidade de campos" 
    SHELL PRINT HELP TO cPrintParams
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF
    SHELL GET PARAMS TO hParams
    */
    IF FILE( "dic_tables.dbf" ) 
    ELSE     
        SHELL ERROR "As tabela do dicionário não foi encontrada" ERRORCODE 100
    ENDIF
    USE ( "dic_tables" ) SHARED
    DO WHILE .NOT. EOF()
        ? FIELD->TTABLE
        SKIP
    ENDDO
    
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

