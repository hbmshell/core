// Shebang line
/**
Description
-----------
Add months a date

To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

    ? "Add 3 months : ", AddMonth( Date(), 3 )
    ? "Add 1 month to 2020-02-28", AddMonth( STOD("20200228") , 1 ) // 2020-03-28
    ? "Add 1 month to 2020-02-29" , AddMonth( STOD("20200229") , 1 ) // 2020-03-29
    ? "Add 2 month to 2020-02-28" , AddMonth( STOD("20200228") , 2 ) // 2020-04-28
     ? "Add 1 month to 2020-01-31" , AddMonth( STOD("20200131") , 1 ) // 2020-02-29
  

RETURN
