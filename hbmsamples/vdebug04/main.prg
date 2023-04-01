//#define __DEBUG__
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL cDebug := "debug.log"
    LOCAL cContent

/**
O comando DEBUG MINI DUMP vai exibir variáveis compostas (arrays e hashs) em apenas uma linha, sem
entrar nos ítens da árvore para exibir de um por um.
*/

    DEBUG MINI DUMP { "Test02" , { "Test03" => "ok" } } 
    cContent := MemoRead( cDebug )
    ? cContent
    ?
    ? "Erasing file now"
    Ferase( cDebug )


    RETURN


