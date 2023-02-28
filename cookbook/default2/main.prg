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

    a := hb_DefaultValue( a , 10 )

    ? "Parameter : " , a 
    ? "-----------------------"
 
RETURN