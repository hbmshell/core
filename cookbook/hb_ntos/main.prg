// https://harbour.github.io/doc/harbour.html#hb_ntos
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main
    LOCAL n := ( 5 / 2 ) + 0.009

    ? Str( n )      // -->          2.51
    ? hb_ntos( n )  // --> 2.51

RETURN
