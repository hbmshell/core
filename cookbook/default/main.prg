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
    FTeste( "String" ) // Diferent data type 
    FTeste( .t. ) // Diferent data type 

RETURN

PROCEDURE FTeste( a )

    hb_Default( @a , 10 )

    ? "Parameter : " , a 
    ? "-----------------------"
 
RETURN