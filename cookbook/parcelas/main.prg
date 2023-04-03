
PROCEDURE Hbm_parcelas( ... )


    cls
    
    dDtCompra := date()
    nDiaVenc := 10
    nQtdDias := 3
    nParcelas := 5
    ? "Date purchase : " , dDtCompra
    ? "Credit card due date : ", nDiaVenc
    ? "Number of days to subtract from due date to get the best day :" , nQtdDias
    ? "Number of installments :", nParcelas
    ? "Array : "
    aResult := ArrayDtVenc( dDtCompra, nDiaVenc , nQtdDias , nParcelas , .f. )
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

