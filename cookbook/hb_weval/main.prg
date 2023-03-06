// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL x := 0
    LOCAL bBlock := {||++x}

    ? "Without work area openned", hb_WAEval( bBlock )


    dbCreate( "agenda", { { "X1", "C", 20, 0 } } , "SQLMIX", .T.)
    
    ? "1 work area openned", hb_WAEval( bBlock )

    dbCreate( "manual", { { "X2", "C", 20, 0 } } , "SQLMIX", .T.) // Now : 2 work areas openned (agenda and manual)

    ? "2 work area openned", hb_WAEval( bBlock ) // Return last value (but all are processed)

RETURN
