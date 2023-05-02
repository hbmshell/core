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

    Do("MyProcedure", 10, 20, 30 ) 
    
RETURN

PROCEDURE MyProcedure( a , b , c )

    ? a + b + c

RETURN
