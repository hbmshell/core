// Shebang line
/**
To build
--------

hbmk2 main.prg hbct.hbc

*/
PROCEDURE Main

    ? TimeValid( Time() ) // .t.
    ? TimeValid( "27:01:89" ) // .f.
    ? TimeValid( "10:58" ) // .t.
    ? TimeValid( "00:60" ) // .f.
 
RETURN
