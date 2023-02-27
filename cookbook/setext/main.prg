// https://www.kresin.ru/en/hrbfaq_3.html
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL cFullPath := "C:\new\harbour\report.txt"

    ? "Before : ", cFullPath
    ? "After  : ", hb_FNameExtSet( cFullPath, ".pdf" )

RETURN
