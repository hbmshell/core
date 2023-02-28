// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    Func01( 1 , 2, 3 )
    Func01( 4 , 5 , 6 , 7 )
    Func01( "one" , "two" , "three" , "four" , "five" , "six", "seven", "eight" , "nine", "ten" , "Beyond Infinity")

RETURN

PROCEDURE Func01( ... )

    LOCAL aParams := hb_AParams(),x

    FOR x := 1 TO LEN( aParams )
        ? aParams[x]
    NEXT

RETURN