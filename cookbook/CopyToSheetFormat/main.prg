#!/usr/local/bin/hbmshell

**********************************************
* Nome  : Hbm_gsheet
* Autor : Vlademiro Landim Junior
* Aviso : Copyright(c) - 2023
*         Vlademiro Landim 
*         Todos os direitos reservados
* Data  : 2023-02-14
* Versão: Harbour 3.2.0dev (r2302011249)
* Notas : 
/*
*/
***********************************************
PROCEDURE Hbm_gsheet( ... )
    MODULE SHELL
    //MODULE ERRORLEVEL
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
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams , cListErrors )
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    y=0
    FOR x := 4 TO 550 STEP 2
        WriteLN "='Página1'!A" + hb_ntos( x ) + Chr(K_TAB) + "='Página1'!B" + hb_ntos( x ) + Chr(K_TAB) +  "='Página1'!F" + hb_ntos( x ) + Chr(K_TAB) + '=A'+hb_ntos(++y)+'*2'

    NEXT

    //SHELL DEBUG hParams
    //SHELL DEBUG aData

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
