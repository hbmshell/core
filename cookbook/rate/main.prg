// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

// You get a loan of 5172.56, pay 100 back every month for
// 5 years (60 months). The effective interest rate per
// period (=month) is

? Rate( 5172.56, 100, 60 ) // --> 0.005
    
RETURN
