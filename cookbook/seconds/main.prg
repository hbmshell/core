// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL nStart, nElapsed
        nStart:= SECONDS()
        FOR x := 1 TO 1000
            FOR y := 1 TO 100
            NEXT
        NEXT
        nElapsed:= SECONDS() - nStart
        ? "Elapsed: " + LTRIM(STR(nElapsed)) + " seconds"


RETURN
