// Shebang line
/**
To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

    ? Date(), " --> ", LastDayOM( Date() ) // Parameter is date
    ? Month(Date()), " --> ", LastDayOM( Month(Date()) ) // Parameter is number of month

RETURN
