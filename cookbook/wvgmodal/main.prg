//http://www.pctoledo.com.br/forum/viewtopic.php?f=47&t=26853&start=15
#include "wvgparts.ch"
#include "hbgtwvg.ch"
#include "wvtwin.ch"

PROCEDURE Main

   LOCAL cTeste := Space(50), GetList := {}, oBtn

   SetMode(33,90)
   SetColor( "W/B" )
   CLS
   WITH OBJECT oBtn := wvgPushButton():New()
      :PointerFocus := .F.
      :Create( , , { -1, -1 }, { -10, -10 } )
      :SetCaption( "teste1" )
      :Activate := { || teste2() }
   ENDWITH

   @ 12, 0 SAY "teste1" GET cTeste
   READ

   (oBtn)

   RETURN

PROCEDURE teste2()

   STATIC nNumTela := 1
   LOCAL cTeste := Space(20), GetList := {}, oBtn, oCrt

   oCrt := wvgCrt():New()
   oCrt:lModal := .T.
   oCrt:Create( ,,{ 0, 0 }, { 25, 80 } )
   nNumTela += 1
   SetColor( "W/R" )
   CLS
   WITH OBJECT oBtn := wvgPushButton():New()
      :PointerFocus := .F.
      :Create( oCrt, , { -1, -1 }, { -10, -10 } )
      :SetCaption( "teste" + Ltrim( Str( nNumTela ) ) )
      :Activate := { || teste2() }
   ENDWITH

   @ 12, 0 SAY "teste2" GET cTeste
   READ
   oCrt:Destroy()
   (oBtn)

   RETURN

PROCEDURE HB_GTSYS

   REQUEST HB_GT_WVG_DEFAULT

   RETURN