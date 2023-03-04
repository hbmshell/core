// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

// Payment of 1000 per year for 10 years at a interest rate
// of 5 per cent per year

? FV( 1000, 0.05, 10 )  // --> 12577.893
    
RETURN
