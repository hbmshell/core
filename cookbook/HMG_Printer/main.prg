#include "hmg.ch"
/*
 * HMG - Harbour Win32 GUI library
 * Copyright 2002-2008 Roberto Lopez <mail.box.hmg@gmail.com>
 * http://www.hmgforum.com//
*/

Function hb_Main()

set century on
set date ital

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 200 ;
      HEIGHT 200 ;
      MAIN;
      TITLE 'Get printer'

      DEFINE MAIN MENU

      END MENU

      @ 30,70 BUTTON Button_1 PICTURE "button.bmp" WIDTH 50 HEIGHT 50 ACTION getprinter()
 

   END WINDOW

   CENTER WINDOW Form_1

   ACTIVATE WINDOW Form_1

Return
