// http://www.elektrosoft.it/tutorials/harbour-how-to/harbour-how-to.asp#time
/**
Description
-----------


To build
--------

hbmk2 main.prg  hbct.hbc

*/
#include "inkey.ch"

PROCEDURE main()

   LOCAL nOption

   CLEAR SCREEN

   SET KEY K_F10 TO TheBeep()
   KEYTIME( K_F10, "07:40:00" )

   nOption = 1
   @ 10, 10 PROMPT "Option 1........."
   @ 11, 10 PROMPT "Option 2........."
   @ 12, 10 PROMPT "Option 3........."
   @ 13, 10 PROMPT "Option 4........."
   MENU TO nOption

   SET KEY K_F10 TO
   KEYTIME()

   RETURN

PROCEDURE TheBeep()

   Tone( 2000, 18 )

   RETURN