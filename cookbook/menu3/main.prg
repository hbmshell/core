#include "Button.ch"
#include "Inkey.ch"

PROCEDURE Main
   LOCAL oTopBar := CreateMainMenu()

   CLS

   DO WHILE .T.
      MenuModal( oTopBar , 1, ;
                 MaxRow(), 0, MaxCol(), ;
                 oTopBar:colorSpec )
   ENDDO
RETURN

FUNCTION CreateMainMenu()
   LOCAL oMainMenu  := HBTopBarMenu():new( 0, 0, MaxCol() )
   LOCAL bMenuBlock := {|o| MenuSelect(o) }
   LOCAL cMenuColor := "N/BG,W+/R,GR+/BG,GR+/R,N+/BG,N/BG"
   LOCAL aItems

   oMainMenu:colorSpec := cMenuColor
   aItems := { ;
      { " &Teste For...Next "     , K_ALT_T   , "Teste For Next"  , 11 }, ;
      { " &Save "     , K_ALT_S   , "Save routine"  , 12 }, ;
      { MENU_SEPARATOR,           ,                 , 13 }, ;
      { " E&xit "     , K_ALT_X   , "Exit program"  , 14 }  ;
   }

   CreateSubMenu( oMainMenu, " &File ", bMenuBlock, aItems )

   aItems := { ;
      { " Cop&y   "   , K_CTRL_INS, "Copy routine"  , 21 }, ;
      { " &Paste  "   , K_ALT_P  , "Paste routine" , 22 }, ;
      { MENU_SEPARATOR,           ,                 , 23 }, ;
      { " C&ut    "   , K_ALT_U  , "Cut routine"   , 24 }, ;
      { " &Delete "   , K_DEL     , "Delete routine", 25 }  ;
   }

   CreateSubMenu( oMainMenu, " &Edit ", bMenuBlock, aItems )

   aItems := { ;
      { " &Info   "   , K_F1      , "Help routine"  , 31 }, ;
      { " &About  "   ,           , "About program" , 32 }  ;
   }

   CreateSubMenu( oMainMenu, " &Help ", bMenuBlock, aItems )

RETURN oMainMenu

FUNCTION CreateSubMenu( oMenu, cMenuItem, bBlock, aItems )
   LOCAL aItem, oItem, oSubMenu

   oSubMenu           := PopUp():new()
   oSubMenu:colorSpec := oMenu:colorSpec

   FOR EACH aItem IN aItems
      oItem := MenuItem():new( aItem[1], ;
                               bBlock  , ;
                               aItem[2], ;
                               aItem[3], ;
                               aitem[4]  )
      oSubMenu:addItem ( oItem )
   NEXT

   oItem := MenuItem():new( cMenuItem, oSubMenu )
   oMenu:addItem( oItem )
RETURN

PROCEDURE MenuSelect( oMenuItem )
   @ 1, 0 CLEAR TO MaxRow(), MaxCol()

   DO CASE
      CASE oMenuItem:ID=11
         TesteForNext()
      CASE oMenuItem:ID=14
         ExitRoutine()
   OTHERWISE
      Alert( oMenuItem:message )
   ENDCASE
RETURN

PROCEDURE ExitRoutine
   IF Alert( "Exit program?", { "Yes", "No" } ) == 1
      QUIT
   ENDIF
RETURN

PROCEDURE TesteForNext()
   LOCAL nContFor:=0
   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   For x=1 To 10
      nContFor+=1
   Next

   Alert("Contador For Next: "+str(nContFor,4,0))

RETURN