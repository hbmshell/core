#!/usr/local/bin/hbmshell -diavenc XXX -qtddias 5 -parcelas 5 -diavenc 20

PROCEDURE Hbm_parcelas( ... )
    MODULE SHELL
    //MODULE ERRORLEVEL
    LOCAL hParams , aData, cPrintParams, cListErrors 
    LOCAL aPipe, x
    LOCAL dDtCompra, nDiaVenc, nQtdDias, nParcelas, aResult
    **************************************Modelos***************************************
    * SHELL ADD PARAM "-primeiro" TITLE "Primeiro" // Parametro que não requer valor
    * SHELL ADD PARAM "-segundo" TITLE "Segundo" DEFAULT "Default Value" // Com valor default
    * SHELL ADD PARAM "-terceiro" TITLE "Terceiro" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    * SHELL ADD PARAM "-quarto" TITLE "Quarto" REQUIRE VALUE // Opcional (mas for usar, deve informar um valor)
    * SHELL PRINT HELP TO cPrintParams
    * ERRORLEVEL 10 MESSAGE "Mensagem de erro com errorlevel 10 / teste agora : echo $? (ENTER)"
    * ERRORLEVEL QUIT WITH 10
    * ERRORLEVEL PRINT HELP TO cListErrors
    ************************************************************************************

    SET DATE FORMAT TO "yyyy-mm-dd"
    SHELL ADD PARAM "-dtcompra" TITLE "Data da Compra" DEFAULT DTOC(Date())
    SHELL ADD PARAM "-diavenc" TITLE "Dia do vencimento do seu cartão" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "-qtddias" TITLE "Quantidade de dias a subtrair do vencimento para obter o melhor dia" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "-parcelas" TITLE "Parcelas" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "-debug" TITLE "Debug" 
    SHELL PRINT HELP TO cPrintParams
    IF hb_PValue(1) == "-help"
        Hbm_Help( cPrintParams , cListErrors )
    ENDIF

    SHELL GET PARAMS TO hParams 

    dDtCompra := CTOD(hParams["-dtcompra"])
    nDiaVenc := VAL( hParams["-diavenc"])
    nQtdDias := VAL( hParams["-qtddias"])
    nParcelas := VAL( hParams["-parcelas"])
    ? "Date purchase : " , dDtCompra
    ? "Credit card due date : ", nDiaVenc
    ? "Number of days to subtract from due date to get the best day :" , nQtdDias
    ? "Number of installments :", nParcelas
    ? "Array : "
    aResult := ArrayDtVenc( dDtCompra, nDiaVenc , nQtdDias , nParcelas , hParams["-debug"]) 
    for X := 1 to len( aResult ) 
        ? aResult[x]
    next    

    //SHELL DEBUG hParams
    //SHELL DEBUG aData
RETURN
/**

*/
STATIC FUNCTION ArrayDtVenc( dDtCompra, nDiaVenc , nQtdDias , nParcelas , lDebug )

    LOCAL aDtVenc := {}
    LOCAL dDtVenc := CalculaDataVencimento( dDtCompra , nDiaVenc )
    LOCAL nYear, nMonth
    LOCAL x 
    LOCAL dDataDiaMelhor := dDtVenc - nQtdDias

    IF lDebug
        ?  "Data da compra : " , dDtCompra
        ?  "Data de corte (melhor dia) : " , dDataDiaMelhor 
        ?  "Data de vencimento : " , dDtVenc
    ENDIF
    IF dDtCompra >= dDataDiaMelhor
        nMonth := MONTH( EOM(dDtVenc) + 1 )
        nYear := YEAR( EOM(dDtVenc) + 1 )
    ELSE
        nMonth := MONTH( EOM(dDtVenc)  )
        nYear := YEAR( EOM(dDtVenc)  )
    ENDIF
        
    FOR x := 1 TO nParcelas
        dDtVenc := STOD(  STR( nYear,4) + StrZero(nMonth,2) + STRZERO( nDiaVenc , 2 ) )
        nMonth := MONTH( EOM( dDtVenc ) + 1 )
        nYear := YEAR( EOM( dDtVenc ) + 1 )
        AADD( aDtVenc , dDtVenc )
    NEXT    

RETURN aDtVenc    
/**
CalculaVencimento( dDtCompra, nDiaVenc )

Entrada :
    dDtCompra : Data da compra
    nDiaVenc  : Dia do vencimento

Saída : dDataVencimento
    
Processamento :
--------

O cálculo da data de vencimento é feito da seguinte forma:

Se ( Dia da Data de Compra ) > Dia do Vencimento do Cartão
    Data de Vencimento vai para o mês seguinte
Senão
    Data de Vencimento inalterada
*/
STATIC FUNCTION CalculaDataVencimento( dDtCompra , nDiaVenc )

    LOCAL dDataVencimento 
    LOCAL nMes, nAno

    IF DAY( dDtCompra ) >= nDiaVenc
        nMes := MONTH( EOM( dDtCompra ) + 1 )
        nAno := YEAR( EOM( dDtCompra ) + 1 )
    ELSE
        nMes := MONTH( EOM( dDtCompra )  )
        nAno := YEAR( EOM( dDtCompra )  )
    ENDIF    
    dDataVencimento := STOD( Str(nAno,4) + StrZero(nMes,2) + StrZero(nDiaVenc,2) )
    
RETURN dDataVencimento
/**
Help
*/
STATIC PROCEDURE Hbm_Help( cPrintParams , cListErrors )

    hb_Default( @cPrintParams , "");hb_Default( @cListErrors , "" )
    ? "Objetivo : Cálculo das datas da compra parcelada com cartão de crédito"
    ?
    ? "Parâmetros"
    ? "-help    Help"
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

