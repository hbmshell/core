//-p

**********************************************
* Nome  : Hbm_wordrand
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
PROCEDURE Hbm_wordrand( ... )
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
    ************************************************************************************
    IF IS_PIPE_CONTENT()
        PIPE TO aPipe AS ARRAY
        FOR x := 1 TO LEN( aPipe )
            SHELL ADD DATA aPipe[x]
        NEXT
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData

    USE word
    PACK
    GOTO hb_RandomInt( 1 , RECCOUNT() )
    ? Field->Word , " ? "
    IF VLJ_CMDYESNO( "Deseja ver a resposta agora ?" , { "S" , "N" } , 2 )
        ? Field->Meaning
    ELSE
        RETURN
    ENDIF    
    IF VLJ_CMDYESNO( "A resposta está certa ?" , { "S" , "N" } , 2 )
        REPLACE FIELD->TOTAL WITH FIELD->TOTAL+1
        REPLACE FIELD->RIGHT WITH FIELD->RIGHT+1
    ELSE    
        REPLACE FIELD->TOTAL WITH FIELD->TOTAL+1
        REPLACE FIELD->ERROR WITH FIELD->ERROR+1
    ENDIF    
        

    //SHELL DEBUG hParams
    //SHELL DEBUG aData

RETURN
