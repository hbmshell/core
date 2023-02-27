// https://vivaclipper.wordpress.com/2014/02/14/switch/
/**
Description
-----------
Switch example

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main
    LOCAL cSName := "Doe"
    
    SWITCH cSName

       CASE "Abba"
          ? "Abaneoer"
          EXIT

       CASE "Bo"
          ? "Boeing"
          EXIT
       CASE "Doe"
          ? "John"
          EXIT

       OTHERWISE
          ? "Guest"
    END

    ?? '', cSName
    ?

RETURN
