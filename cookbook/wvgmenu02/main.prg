/*
 menu.prg
 compile : hbmk2 menu -gtwvg.hbc hbct.hbc
*/

#include "inkey.ch"
#include "button.ch"
#include "hbgtinfo.ch"

//REQUEST HB_GT_WVT_DEFAULT

//REQUEST HB_GT_WVG

PROCEDURE Main()
	LOCAL oldColor, pGT
   LOCAL  lMouse := MSETCURSOR ( .T. )

   SET DATE BRITISH
   SET EPOCH TO 1970
   SET ( _SET_SCOREBOARD, .F. )

   hb_gtInfo( HB_GTI_CLOSABLE, .F.  )
	
   SetBlink( .F. )

	? "GT driver to use? (1=wvt, 2=wvg)"
		
	if inkey(0) == 50
		CLS
		pGT := hb_gtCreate( "WVG" )
		pGT := hb_gtSelect( pGT )
	endif
	
	oldColor := SetColor( "G+/N*" )
	
	CLS
	
   MENU()

   CLOSE ALL

   MSETCURSOR( lMouse )
	SetColor( oldColor )
	
   RETURN
	
FUNCTION MENU()
   LOCAL oInfo
	LOCAL lExit := .F.
   // SET( _SET_EVENTMASK, HB_INKEY_ALL )
   SET ( _SET_EVENTMASK,  hb_bitOr( hb_bitAnd( INKEY_ALL, hb_bitNot( INKEY_MOVE ) ), HB_INKEY_GTEVENT, HB_INKEY_EXT ) )

   oInfo := MenuCreate()

   SetKey( K_ALT_F4, ExitMenu() )

   SetKey( HB_K_CLOSE, { || __keyboard( Chr( K_ESC ) ) } ) // this could be more effective, this is just a sample!

   WHILE ! lExit

      MENUMODAL( oInfo, 1, 24, 0, 79, "r/w" )

      IF hb_Alert("Close program and exit;Are you sure?", { "Yes!", "No!" } ) == 1
         ExitNow()
			EXIT
      ENDIF

   END

   SetKey( K_ALT_F4, NIL )

   RETURN ( NIL )

FUNCTION MenuCreate()
   LOCAL oTopBar, oPopUp, oMenuItem
   oTopBar := TopBar( 0, 0, 79 )
   oTopBar:ColorSpec := "N/W,GR+/B*,R/W,GR+/B*,N+/W,N+/W" // "N/BG,GR+/R,R/BG,GR+/R,N+/BG,N/BG"

   oTopBar:AddItem( MENUITEM ( "&Files       ", FilePopUp( oTopBar:ColorSpec ),, "Files operations" ) )

   oTopBar:AddItem( MENUITEM ( "&Transactions", TransPopUp( oTopBar:ColorSpec ),, "Sales, Orders, etc" ) )

   oPopUp := POPUP()
   oPopUp:ColorSpec := oTopBar:ColorSpec
   oPopUp:AddItem( MENUITEM( "&About this program" , { || hb_Alert( "Hi!") },, "Application info" ) )
   oTopBar:AddItem( MENUITEM ( "&Help", oPopUp,, "Help message" ) )

   RETURN ( oTopBar )

STATIC FUNCTION FilePopUp( cColorSpec )
   LOCAL oPop1
   oPop1 := POPUP()
   oPop1:ColorSpec := cColorSpec
   oPop1:AddItem( MENUITEM( "&Inventory      Alt+F5" , { || dummy() }, K_ALT_F5, "Inventory control" ) )
   oPop1:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop1:AddItem( MENUITEM( "&Customers            " , { || dummy() },, "C.R.M." ) )
   oPop1:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop1:AddItem( MENUITEM( "&Suppliers            " , { || dummy() },, "Suppliers" ) )
   oPop1:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop1:AddItem( MENUITEM( "&Exit  Alt+F4         " , { || ExitMenu() }, K_ALT_F4, "End of work!" ) )
   RETURN oPop1

STATIC FUNCTION TransPopUp( cColorSpec )
   LOCAL oPop1, oPop2
   oPop1 := POPUP()
   oPop1:ColorSpec := cColorSpec
   
	oPop2 := POPUP()
   oPop2:ColorSpec := cColorSpec
   oPop2:AddItem( MENUITEM( "&Invoices         " , { || dummy() },, "bottom row message..." ) )
   oPop2:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop2:AddItem( MENUITEM( "Show Invoices     " , { || dummy() },, "message..." ) )
   oPop2:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop2:AddItem( MENUITEM( "Delete Invoices   " , { || dummy() },, "message..." ) )
   oPop1:AddItem( MENUITEM( "&Sales", oPop2,, "message..." ) )
   oPop1:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop2 := POPUP()
   oPop2:ColorSpec := cColorSpec
   oPop2:AddItem( MENUITEM( "&Puchase Orders" , { || dummy() },, "Εκδοση παραστατικών πωλήσεων..." ) )
   oPop2:AddItem( MENUITEM( MENU_SEPARATOR ) )
   oPop2:AddItem( MENUITEM( "Show Orders" , { || dummy() },, "Προβολή εκδοθέντων παραστατικών αγορών..." ) )
   oPop1:AddItem( MENUITEM( "&Purchases" , oPop2,, "Διαχείριση αγορών..." ) )

   RETURN oPop1


FUNCTION ExitMenu()
   STATIC Ins := .F.
   IF Ins
      KEYBOARD Chr( K_ESC )
   ELSE
      Ins := .T.
   ENDIF
   RETURN 0

STATIC FUNCTION ExitNow()

   LOCAL  nChoice, cBye, nTime
   nTime := Val( Left( Time(), 2 ) )
   IF nTime < 12
      cBye := "Have a good day!"
   ELSEIF nTime < 19
      cBye := "Have a good time!"
   ELSE
      cBye := "Goodnight!"
   ENDIF
   CLOSE all
   Scroll()
   hb_Alert( "END OF DAY!;Thanks for your hard work!;", { cBye }, , 2 )
	
   RETURN

FUNCTION dummy()
	
    alert("ok")
	
	RETURN .T.
	