#include "vbase.ch"
#include "hbclass.ch"
/*
Exemplo de USO INCORRETO da cláusula UPDATE LAST MESSAGE. 

Lembre-se: ela deve ser usada sempre dentro de uma classe derivada de VObject. 
Veja vlog04.prg para maiores informações.
*/

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent

    CLS
    CONFIG LOG LEVEL INFO
    LOG "Hello World" INFO UPDATE LAST MESSAGE
    
    ?
    ?
    ? "Type any key to continue."
    Inkey(0)
    cContent := MemoRead( oCfg:GetLogName() )
    ? "-------------------------------------"
    ? "- Content (Log file generated : " + oCfg:GetLogName() + ")"
    ? "-------------------------------------"
    ? cContent
    ?
    ? "Erasing file now"
    Ferase( oCfg:GetLogName() )


    RETURN


