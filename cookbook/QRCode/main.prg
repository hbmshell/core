/*
 *
 * Copyright 2010 Viktor Szakats (vszakats.net/harbour)
 *
 */


#include "harupdf.ch"
PROCEDURE Main()

   LOCAL pdf
   LOCAL page
   LOCAL cFile := "out"
   LOCAL hZebra, nLineHeight, cTxt // Zebra
   LOCAL nY

   pdf := HPDF_New()
   page := HPDF_AddPage( pdf )
   HPDF_Page_SetSize( page, HPDF_PAGE_SIZE_A4, HPDF_PAGE_PORTRAIT )
   HPDF_Page_SetFontAndSize( page, HPDF_GetFont( pdf, "Helvetica", NIL ), 12 )

   //DrawBarcode( page, 580,   1, "QRCODE",     "http://harbour.github.io/" )
   nY := 580
   nY := HPDF_Page_GetHeight( page ) - nY
   hZebra := hb_zebra_create_qrcode( "QRCODE", /*nFlags*/ )
   nLineWidth := 1
   nLineHeight := nLineWidth
   IF hZebra != NIL
      IF hb_zebra_geterror( hZebra ) == 0
         IF Empty( nLineHeight )
            nLineHeight := 16
         ENDIF
         HPDF_Page_BeginText( page )
         HPDF_Page_TextOut( page,  40, nY - 13, "QRCode" )
         cTxt := hb_zebra_getcode( hZebra )
         IF Len( cTxt ) < 20
            HPDF_Page_TextOut( page, 150, nY - 13, cTxt )
         ENDIF
         HPDF_Page_EndText( page )
         hb_zebra_draw_hpdf( hZebra, page, 300, nY, nLineWidth, -nLineHeight )
      ELSE
         ? "Type", "QRCode", "Code", cCode, "Error", hb_zebra_geterror( hZebra )
      ENDIF
      hb_zebra_destroy( hZebra )
   ELSE
      ? "Invalid barcode type", "QRCode"
   ENDIF

   FErase( hb_FNameExtSet( cFile, ".pdf" ) )
   ? HPDF_SaveToFile( pdf, hb_FNameExtSet( cFile, ".pdf" ) )

   RETURN

PROCEDURE DrawBarcode( page, nY, nLineWidth, cType, cCode, nFlags )

   LOCAL hZebra, nLineHeight, cTxt

   nY := HPDF_Page_GetHeight( page ) - nY

   hZebra := hb_zebra_create_qrcode( cCode, nFlags )
   nLineHeight := nLineWidth


   IF hZebra != NIL
      IF hb_zebra_geterror( hZebra ) == 0
         IF Empty( nLineHeight )
            nLineHeight := 16
         ENDIF
         HPDF_Page_BeginText( page )
         HPDF_Page_TextOut( page,  40, nY - 13, cType )
         cTxt := hb_zebra_getcode( hZebra )
         IF Len( cTxt ) < 20
            HPDF_Page_TextOut( page, 150, nY - 13, cTxt )
         ENDIF
         HPDF_Page_EndText( page )
         hb_zebra_draw_hpdf( hZebra, page, 300, nY, nLineWidth, -nLineHeight )
      ELSE
         ? "Type", cType, "Code", cCode, "Error", hb_zebra_geterror( hZebra )
      ENDIF
      hb_zebra_destroy( hZebra )
   ELSE
      ? "Invalid barcode type", cType
   ENDIF

   RETURN

STATIC FUNCTION hb_zebra_draw_hpdf( hZebra, page, ... )

   IF hb_zebra_geterror( hZebra ) != 0
      RETURN HB_ZEBRA_ERROR_INVALIDZEBRA
   ENDIF

   hb_zebra_draw( hZebra, {| x, y, w, h | HPDF_Page_Rectangle( page, x, y, w, h ) }, ... )

   HPDF_Page_Fill( page )

   RETURN 0