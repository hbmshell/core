#include "inkey.ch"
#include "hbclass.ch"
#include "wvgparts.ch"

PROCEDURE Main
   LOCAL nCont, oThisButton, nCol
   SetMode( 24, 80 )
   CLS
   nCol := 1
   FOR nCont = 1 TO 5
      oThisButton := WvgPushButton():New()
      oThisButton:PointerFocus := .f.
      IF nCont > 1
         oThisButton:Caption := { "Command", WVG_IMAGE_ICONRESOURCE, "SEARCHWEB" }
      ELSE 
         oThisButton:Caption := hb_DirBase() + "searchWeb.ico"
      ENDIF
      
      oThisButton:Create( , , { -1, -nCol }, { -3, -5 } )
      nCol += 5
   NEXT
   @ 6, 0 SAY "First icon from file and others from resource"
   Inkey(0)
   RETURN