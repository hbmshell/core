// http://www.pctoledo.com.br/forum/viewtopic.php?f=1&t=5769
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL nStart, nElapsed
        ? "Start : ", nStart:= hb_MilliSeconds(), "Millisecconds"
        FOR x := 1 TO 1000
            FOR y := 1 TO 100
            NEXT
        NEXT
        ? "End   : ", nElapsed:= hb_MilliSeconds(), "Millisecconds"
        ? "Elapsed: " + LTRIM(STR(nElapsed - nStart)) + " miliseconds"


RETURN
