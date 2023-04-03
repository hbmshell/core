#include "hwgui.ch"

       Function Main
       Local oMainWnd, oFont
       Local aCombo := {"First","Second" }

          PREPARE FONT oFont NAME "MS Sans Serif" WIDTH 0 HEIGHT -13

          INIT WINDOW oMainWnd TITLE "Example" ;
             FONT oFont ;
             ON EXIT {||hwg_MsgYesNo("Really want to quit ?")}

          @ 20,10 EDITBOX "Hello, World!" SIZE 200,30

          @ 270,10 COMBOBOX aCombo SIZE 100, 150 TOOLTIP "Combobox"

          @ 120,60 BUTTON "Close" SIZE 150,30 ;
             ON CLICK {||oMainWnd:Close()}

          MENU OF oMainWnd
             MENUITEM "About" ACTION hwg_MsgInfo("First HwGUI Application")
          ENDMENU

          ACTIVATE WINDOW oMainWnd

          hwg_writelog( "Program terminated " + Dtoc(Date()) + " at " + Time() )

      Return