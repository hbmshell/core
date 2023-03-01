// Shebang line
/**
Description
-----------
Returns the date as a string in DD Month YY format

To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

    ? Dmy( Date(), .f. )
    ? Dmy( Date(), .t. ) // If TRUE, a "." is inserted after the DD. 

RETURN
