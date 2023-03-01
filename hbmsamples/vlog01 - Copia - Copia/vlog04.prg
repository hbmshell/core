#include "vbase.ch"
#include "hbclass.ch"
/*
Esse exemplo mostra como usar a cláusula UPDATE LAST MESSAGE do comando LOG.

Observações e pré-requisitos :

1. Esse comando só pode ser usado no interior de uma classe
2. Essa classe deve ter o método ::setLastMessage
3. Classes derivadas de VOBject tem esse método. Por isso a sua classe deve herdar de VObject

Conclusão: UPDATE LAST MESSAGE deve ser usada dentro de uma classe derivada de VObject. 

*/
CLASS myClass INHERIT VOBject

    DATA cVar INIT "Hello World"

    METHOD MyProc()

END CLASS    

METHOD MyProc CLASS myClass

    LOG "Hello World" INFO UPDATE LAST MESSAGE

RETURN 

PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL cContent
    LOCAL oTest := myClass():New()

    CLS
    CONFIG LOG LEVEL INFO
    
    oTest:MyProc()

    ? "LastMessage in oTest : " , oTest:getLastMessage()
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


