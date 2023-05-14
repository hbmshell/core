/**
To build
--------

hbmk2 main.prg 

*/
PROCEDURE main

   ? hb_ValToExp( StringToArray( "Programa's Project" ) )


RETURN

FUNCTION StringToArray( s )

    LOCAL a := {}, cElem  
    FOR EACH cElem IN s
        AADD( a , cElem )
    NEXT

RETURN a