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

    **************************************Modelos***************************************
    * SHELL ADD PARAM "--primeiro" TITLE "Primeiro" // Parametro que não requer valor
    * SHELL ADD PARAM "--segundo" TITLE "Segundo" DEFAULT "Default Value" // Com valor default
    * SHELL ADD PARAM "--terceiro" TITLE "Terceiro" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    * SHELL ADD PARAM "--quarto" TITLE "Quarto" REQUIRE VALUE // Opcional (mas for usar, deve informar um valor)
    * SHELL PRINT HELP TO cPrintParams
    * SHELL ADD ERROR 101 MESSAGE "Erros " // Apenas adiciona a mensagem com o código 101 na pilha e no help
    * ERRORLEVEL 10 MESSAGE "Mensagem de erro com errorlevel 10 / teste agora : echo $? (ENTER)"
    * ERRORLEVEL QUIT WITH 10
    * SHELL MESSAGE ERROR "Exibe uma mensagem de erro e abandona o script sem alterar o código"
    * SHELL MESSAGE ERROR "Exibe uma mensagem de erro e abandona o script alterando o código para 100" ERRORCODE 100
    * ERRORLEVEL PRINT HELP TO cListErrors
    ************************************************************************************
    SHELL ADD PARAM "--first" TITLE "First" REQUIRE VALUE 
    SHELL ADD PARAM "--second" TITLE "Second" REQUIRE VALUE 
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
