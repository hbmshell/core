//#define __DEBUG__
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL cdebug := "debug.log"
    LOCAL cContent
    LOCAL A,B,C,Delta

/**
O comando DEBUG BEGIN BLOCK <TITULO> serve apenas para nomear o inicio de um processamento, isso é útil
porque facilita a identificação visual dos eventos gravados em um log que pertencem a um dado processamento.
Útil para baixa de estoque, baixa de notas, etc.

O comando DEBUG END BLOCK serve apenas para informar que o processamento acabou. 
*/

    DEBUG BEGIN BLOCK "Cálculo do valor de delta"
    a := 10
    b := 3
    c := 2
    delta := b^2-(4*a*c)
    DEBUG MINI DUMP a TITLE "VALOR DE A"
    DEBUG MINI DUMP b TITLE "VALOR DE B"
    DEBUG MINI DUMP c TITLE "VALOR DE C"
    DEBUG MINI DUMP delta TITLE "VALOR DE DELTA"
    DEBUG END BLOCK 
    cContent := MemoRead( cdebug )

    ? cContent
    ?
    ? "Erasing file now"
    Ferase( cdebug )


    RETURN


