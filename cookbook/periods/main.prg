// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

// You get a loan of 5172.56 at a interest rate of 0.5% per
// month (6% per year).
// You can afford to pay 100 back every month, so you need

? Periods( 5172.56, 100, 0.005 ) // --> 60.0

// months to cancel the loan.
    
RETURN
