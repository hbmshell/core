
/*
O valor de nValue foi alterado dentro de Change
*/
PROCEDURE Main()

    LOCAL nValue := 10
    LOCAL nAdd := 0
    LOCAL bBlock := {|| nValue := nValue + nAdd }

    nAdd := 100
    Change( bBlock )
    ? nValue

RETURN
/*
*/
PROCEDURE Change( bExtern )

   EVAL( bExtern )  

RETURN 