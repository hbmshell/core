#include "hmg.ch"
/*
thanks!
http://www.pctoledo.com.br/forum/viewtopic.php?f=45&t=25119&start=15
*/

PROCEDURE Main()

   DEFINE WINDOW MainWindow ;
      AT 100, 100 ;
      WIDTH 640 ;
      HEIGHT 480 ;
      TITLE "Teste" ;
      MAIN

      DEFINE MAIN MENU
         POPUP "Menu"
            ITEM "Janela 1" ACTION telaconsole1()
            ITEM "Janela 2" ACTION telaconsole2()
         END POPUP
      END MENU

   END WINDOW

   ACTIVATE WINDOW MainWindow

RETURN
#define ALT_ENTER .T.
#define CLOSEABLE .T.
STATIC FUNCTION telaconsole1()

   LOCAL cCampo1 := space(30)
   LOCAL pGt 

   pGt := OpenConsole( "Janela console 1", ALT_ENTER , CLOSEABLE )
   IF EMPTY( pGt )
      RETURN NIl
   ENDIF

   @ 10,10 SAY "CAMPO1:" GET cCampo1

   READ

   ? cCampo1

   WAIT

   CloseConsole( pGt )

RETURN NIL

STATIC FUNCTION telaconsole2()

   LOCAL cCampo1 := space(30)
   LOCAL cCampo2 := space(50)
   LOCAL pGt 

   pGt := OpenConsole( "Janela console 1", ALT_ENTER, CLOSEABLE )
   IF EMPTY( pGt )
      RETURN NIl
   ENDIF
   @ 8,10 SAY "CAMPO1:" GET cCampo1
   @ 10,10 SAY "CAMPO2:" GET cCampo2

   READ

   ? cCampo1
   ? cCampo2

   WAIT

   CloseConsole( pGt )

RETURN NIL