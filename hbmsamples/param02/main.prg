#!/bin/hbmshell
//-b
**********************************************
* Nome  : Hbm_main
* Autor : Vlademiro Landim Junior
* Aviso : Copyright(c) - 2023
*         Vlademiro Landim 
*         Todos os direitos reservados
* Data  : 2023-02-25
* Versão: Harbour 3.2.0dev (r2211251714)
* Notas : 
/*
*/
***********************************************
PROCEDURE Hbm_main( ... )
    MODULE SHELL
    MODULE ERRORLEVEL
    LOCAL hParams , aData, cPrintParams, cListErrors 
    LOCAL aPipe, x 

    SHELL ADD PARAM "--first" TITLE "First" MANDATORY REQUIRE VALUE 
    SHELL ADD PARAM "--second" TITLE "Second" MANDATORY REQUIRE VALUE 
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams , cListErrors )
    ENDIF
    IF IS_PIPE_CONTENT()
        PIPE TO aPipe AS ARRAY
        FOR x := 1 TO LEN( aPipe )
            SHELL ADD DATA aPipe[x]
        NEXT
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    ? "Hello World"
    ? "First parameter: ", hParams["--first"]
    ? "Second parameter: ", hParams["--second"]
    SHELL DEBUG hParams
    SHELL DEBUG aData

STATIC PROCEDURE Hbm_Help( cPrintParams , cListErrors )

    hb_Default( @cPrintParams , "");hb_Default( @cListErrors , "" )
    ? "Objetivo : "
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    IF .NOT. EMPTY( cListErrors )
        ? "Códigos de erro"
        ? cListErrors
        ? ""
    ENDIF
    QUIT

RETURN
