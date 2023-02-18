// Shebang line
/**
Description
-----------
How to delete array element

*/
PROCEDURE Main

    LOCAL aTest:= { 1, 2, 3, 4, 5 } 
    
    ? "Array size: " , Len( aTest ) // -> 5

    ? "Deleting 3th element"
    hb_aDel( aTest, 3, .T. )
    ? "Array size now is : ", Len( aTest ) // -> 4 !


RETURN
