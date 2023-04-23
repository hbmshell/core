//http://www.pctoledo.com.br/forum/viewtopic.php?f=47&t=26830&hilit=barra&start=15
#include "wvgparts.ch"
#include "hbgtwvg.ch"
#include "wvtwin.ch"

PROCEDURE Main

   LOCAL cResp := Space(2), GetList := {}, oBtn
   LOCAL oBtnList := { ;
      { -1, -1, -5, -10, 0, "teste", Nil }, ;
      { -1, -11, -5, -10, BS_TOP, "teste", "SEARCHWEB" }, ;
      { -1, -21, -5, -10, BS_BOTTOM, "teste", "SEARCHWEB" }, ;
      { -1, -31, -5, -10, BS_RIGHT, "teste", "SEARCHWEB" }, ;
      { -1, -41, -5, -10, BS_LEFT, "teste", "SEARCHWEB" } }

   SetMode(30,100)
   CLS
   FOR EACH oBtn IN oBtnList
      CreateButton( oBtn )
   NEXT
   @ 12, 5 SAY "Type 'ok' to exit : " GET cResp
   READ

   RETURN

FUNCTION CreateButton( oBtn )

   AAdd( oBtn, Nil )
   WITH OBJECT oBtn[8] := wvgPushButton():New()
      :PointerFocus := .F.
      IF ! Empty( oBtn[5] )
         :Style += oBtn[5]
      ENDIF
      :Create( , , { oBtn[1], oBtn[2] }, { oBtn[3], oBtn[4] } )
      IF ! Empty( oBtn[7] )
         :SetCaption( { , WVG_IMAGE_ICONRESOURCE, oBtn[7] } )
         :sl_Resize := { || ResizeIcon( oBtn[8], oBtn[7] ) }
      ENDIF
      :SetCaption( oBtn[6] )
   ENDWITH

   RETURN oBtn

FUNCTION ResizeIcon( oBtn, cIcon )

   LOCAL aSize, nWidth, nHeight

   WITH OBJECT oBtn
      aSize := :CurrentSize()
      nWidth  := aSize[ 1 ] - 2
      nHeight := aSize[ 2 ] - wvt_GetFontInfo()[ 6 ] - 2
      wvg_SendMessage( :hWnd, BM_SETIMAGE, IMAGE_ICON, wvg_LoadImage( cIcon, 1, IMAGE_ICON, nWidth, nHeight ) )
   ENDWITH

   RETURN Nil
 





