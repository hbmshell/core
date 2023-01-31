
//#include "hmg.ch"

Function Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 500 HEIGHT 300 ;
      TITLE 'EditBox Demo' ;
      MAIN

      @ 30,10 EDITBOX Edit_1 ;
         WIDTH 400 ;
         HEIGHT 200 ;
         VALUE 'DoubleClick demo!!!' 

   END WINDOW


   CREATE EVENT PROCNAME EditBox_DBLCLICK() HWND Form_1.Edit_1.HANDLE STOREINDEX nIndex
   EventProcessAllHookMessage ( nIndex, .T. ) 
   
   Form_1.Center()
   Form_1.Activate()
Return Nil

Function EditBox_DBLCLICK()
      //#define WM_LBUTTONDBLCLK 515 // include in "i_controlmisc.ch"
      IF EventMSG() == WM_LBUTTONDBLCLK
         MsgInfo ("DBLCLICK")
      ENDIF
Return NIL


