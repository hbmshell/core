// https://harbour.github.io/doc/harbour.html#hb_ntos
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL nYear, nDayOfWeek

    ? hb_Week( 0d20170215, @nYear, @nDayOfWeek ), nYear, nDayOfWeek  // --> 7, 2017, 3
    ? hb_Week( Date(), @nYear, @nDayOfWeek ), nYear, nDayOfWeek  

RETURN
