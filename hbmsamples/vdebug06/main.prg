//#define __DEBUG__
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL cdebug := "debug.log"
    LOCAL cContent

/**
O comando DEBUG ENV vai tirar uma cópia do ambiente na qual a aplicação foi gerada, os dados da estação, 
da rede, IP, etc.
*/

    DEBUG ENV
    cContent := MemoRead( cdebug )

    ? cContent
    ?
    ? "Erasing file now"
    Ferase( cdebug )


    RETURN


