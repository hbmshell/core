// Shebang line
/**
Description
-----------
Determines of year of date is a leap year

To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

    LOCAL dDate := Date(),x

    FOR x := 0 TO 10
        dDate := Date() + 365*x 
        ? Year( dDate ), IIF( isLeap(dDate) , " is leap", "isn't leap" )
    NEXT

RETURN
