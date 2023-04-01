//#define __DEBUG__
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL cLog := "mylog.log"
    LOCAL cDebug := "debug.log"
    LOCAL cContent

/**
Pode acontecer de você querer gravar suas informações em um arquivo diferente além do arquivo de log padrão.
Nesse caso use a cláusula FILE
*/

    DEBUG DUMP 1+1 TITLE "1 PLUS 1 EQUAL 2 ;)" TO FILE ( cLog )
    DEBUG DUMP 1+2 TITLE "1 PLUS 2 EQUAL 3 ;)" TO FILE ( cLog )
    DEBUG DUMP 1+3 TITLE "1 PLUS 3 EQUAL 4 ;)" TO FILE ( cLog )

    cContent := MemoRead( "mylog.log" )
    ? "-------------------------------------"
    ? "- Content (Log file generated : " + cLog + ")"
    ? "-------------------------------------"
    ? cContent
    ?
    ? "Erasing file now"
    Ferase( cLog )
    Ferase( cDebug )    

/*
IMPORTANTE: As informações continuarão a serem gravadas no log padrão, 
e serão gravadas também no arquivo informado em FILE.

Por que eu iria gravar em dois logs ?
O log padrão recebe todas as mensagens de log (ERRO,INFO,WARNING) e ele pode ficar muito grande. 
Isso dificulta a busca visual das informações de depuração gravadas, nesse caso, ter um arquivo
só para o log facilita a sua vida.
*/    

    RETURN


