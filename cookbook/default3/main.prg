// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    FTeste( 12 )
    FTeste( "String" ) // Diferent data type but is accepted in legacy method
    FTeste( .t. ) // Diferent data type but is accepted in legacy method

RETURN

PROCEDURE FTeste( a )

    IF a == NIL 
       a := 10 
    ENDIF

    ? "Parameter : " , a 
    ? "-----------------------"
 
RETURN