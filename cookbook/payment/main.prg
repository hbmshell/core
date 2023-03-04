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
    // For 5 years, you have to pay back every month

    ? Payment( 5172.56, 0.005, 60 ) // --> 100.00
    
RETURN
