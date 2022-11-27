# Nhac nhac
/*
O valor de nValue foi alterado dentro de Change
*/
PROCEDURE Main()

    LOCAL nValue := 10

    Change( {|a| nValue := nValue + a } )
    ? nValue

RETURN
/*
*/
PROCEDURE Change( bExtern )

   EVAL( bExtern , 12 )  

RETURN 