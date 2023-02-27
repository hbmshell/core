// https://www.kresin.ru/en/hrbfaq_3.html
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    ? cString := "avião" , hb_strIsUtf8( cString )
    ? cString := "aviao" , hb_strIsUtf8( cString )

RETURN
