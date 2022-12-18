#!/usr/local/bin/hbmediator/hbmshell
**********************************************
* Nome  : Hbm_main2
* Autor : Vlademiro Landim Junior
***********************************************
PROCEDURE Hbm_main2( ... )
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
    SHELL ADD PARAM "-from" TITLE "From" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "-password" TITLE "Password" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "-to" TITLE "To" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "-host" TITLE "Host. E.g: gmail" DEFAULT "gmail"
    SHELL ADD PARAM "-subject" TITLE "Subject" DEFAULT "No Subject"
    SHELL ADD PARAM "-text" TITLE "Text" DEFAULT ""
    IF hb_PValue(1) == "-help"
        Hbm_Help( cPrintParams , cListErrors )
    ENDIF
    IF IS_PIPE_CONTENT()
        PIPE TO aPipe AS ARRAY
        //? hb_ValToExp( __PIPE )
        //aPipe := hb_ATokens( IIF( VALTYPE( __PIPE ) <> "C" , "" , __PIPE ) , .T. )
        FOR x := 1 TO LEN( aPipe )
            SHELL ADD DATA aPipe[x]
        NEXT
    ENDIF
    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    ? "Before send"
    ? "-----------"
    ?
    ? "From : ", hParams["-from"]
    ? "To   : ", hParams["-to"]
    ? "Host : ", hParams["-host"]
    ? "Subject : ", hParams["-subject"]
    ? "Text : ", hParams["-text"]

//
//FUNCTION VLJ_Email(  cFrom , cPassword, cHost, cTo, cSubject, cText , aAnexos, lDebug )

    IF VLJ_EMail( hParams["-from"], hParams["-password"],  hParams["-host"],  hParams["-to"],;
               hParams["-subject"] , hParams["-text"] )
        ? "Success" 
    ELSE
        ? "Fail"
    ENDIF


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
