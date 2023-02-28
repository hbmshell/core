// https://github.com/Petewg/harbour-core/wiki/hb_A
// https://vivaclipper.wordpress.com/2014/01/07/ains/
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL aArray := { "Harbour", "is", "Power!", "!!!" }, xElem, lNewPosition := .t.

    ? "--------------------------"
    ? "Before"
    ? "--------------------------"
    FOR EACH xElem IN aArray
        ? xElem
    NEXT
    ? "--------------------------"
    ? "After"
    ? "--------------------------"
    hb_AIns( aArray, 4 , "New value" , lNewPosition )
    FOR EACH xElem IN aArray
        ? xElem
    NEXT

RETURN
