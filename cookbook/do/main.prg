// Shebang line
/**
Description
-----------
How to call a procedure

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    DO MyProcedure WITH 10, 20, 30 // Legacy mode
    MyProcedure( 10, 20, 30 ) // Preferred method (use this)

RETURN

PROCEDURE MyProcedure( a , b , c )

    ? a + b + c

RETURN
