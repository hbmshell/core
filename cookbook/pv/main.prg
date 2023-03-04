// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

// You can afford to pay back 100 Dollars per month for 5 years
// at a interest rate of 0.5% per month (6% per year), so instead
// of 6000 Dollars (the amount you will pay back) the bank will pay
// you

? PV( 100, 0.005, 60 ) // --> 5172.56
    
RETURN
