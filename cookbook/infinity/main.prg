// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

    ? Infinity( .t. ) // .T., if the function should return the maximum floating point value available (DBL_MAX)
    ? Infinity( .f. ) // .F., function should try to return the same value as the original CT3 lib did Default: .F.

RETURN
