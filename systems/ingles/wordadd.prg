

**********************************************
* Nome  : Hbm_wordadd
* Autor : Vlademiro Landim Junior
* Aviso : Copyright(c) - 2021
*         Vlademiro Landim 
*         Todos os direitos reservados
* Data  : 2021-09-08
* Versão: Harbour 3.2.0dev (r2104281802)
* Notas : 
/*
*/
***********************************************
#include 'cmdterminal.ch' // integração com o shell
PROCEDURE Hbm_wordadd( ... )
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
    * ERRORLEVEL 10 MESSAGE "Mensagem de erro com errorlevel 10 / teste agora : echo $? (ENTER)"
    * ERRORLEVEL QUIT WITH 10
    * ERRORLEVEL PRINT HELP TO cListErrors
    ************************************************************************************
    SHELL ADD PARAM "--word" TITLE "Word" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "--meaning" TITLE "Meaning (Type inner quotation marks)" MANDATORY REQUIRE VALUE
    IF IS_PIPE_CONTENT()
        PIPE TO aPipe AS ARRAY
        FOR x := 1 TO LEN( aPipe )
            SHELL ADD DATA aPipe[x]
        NEXT
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData


    USE word 
    LOCATE FOR UPPER(WORD) = UPPER( hParams["--word"] )
    IF FOUND()
        ? "Word already in file"
    ELSE    
        APPEND BLANK
        REPLACE WORD WITH hParams["--word"]
        REPLACE MEANING WITH hParams["--meaning"]
    ENDIF
    //SHELL DEBUG hParams
    //SHELL DEBUG aData

RETURN
