#!/bin/hbmshell
#include <hbmediator.ch>

PROCEDURE Hbm_main( ... )

    MODULE SHELL
    MODULE ERRORLEVEL
    LOCAL hParams , aData, cPrintParams, cListErrors 
    LOCAL aPipe, x 

    SHELL ADD PARAM "--first" TITLE "First" STRING 
    SHELL ADD PARAM "--second" TITLE "Second" STRING MANDATORY  
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams , cListErrors )
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    ? hb_ValToExp( hParams )
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
