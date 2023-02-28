// https://github.com/Petewg/harbour-core/wiki/hb_A
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL xItem 
    
    FOR EACH xItem IN hb_ACmdLine()
        ? xItem
    NEXT
RETURN
