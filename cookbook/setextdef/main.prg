// https://www.kresin.ru/en/hrbfaq_3.html
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL cFullPath := "C:\new\harbour\reportWithoutExtension"

    ? "Before : ", cFullPath
    ? "After  : ", hb_FNameExtSetDef( cFullPath, ".pdf" )

RETURN
