/*
    Goal: Convert Text file to PDF (hbpdf) with ESC commands
    Based on Fernando sample at http://www.pctoledo.com.br/forum/viewtopic.php?p=90975#p90975
	By: Pablo César Arrascaeta - Semptember 27th, 2014
*/
// Generate :
// hbmk2 main -Ic:\harbour\contrib\hbhpdf hbhpdf.hbc 
#include <harupdf.ch>

#xcommand TRY              => bError := errorBlock( {|oErr| break( oErr ) } ) ;;
                              BEGIN SEQUENCE
#xcommand CATCH [<!oErr!>] => errorBlock( bError ) ;;
                              RECOVER [USING <oErr>] <-oErr-> ;;
                              errorBlock( bError )
Function Main()
Local cName ,  cFilePRN := "LOCA_01.PRN"

   PdfDrawPageDOSNew( "LOCA_01.PRN", "out.pdf", 5, 1, .T., , )

Return Nil

Function PDFDrawPageDOSNew( cPRN, cPDFName, nMargem, nMargemTop, lSilent, lLandScape, lIsEpson )
Local cBuffer := Space(2052), poz := 2052, nLineSpacing := 0, nPage := 1
Local cLine, nRow, nCol, aSetting
Local hFile, nI, nII
Local oPdf, oPage
Local aESC

oPdf := HPDF_New()
HPDF_SetCompressionMode( oPdf, HPDF_COMP_ALL )

// Fonts Setting
oCourier := HPDF_GetFont( oPdf, "Courier", "CP1252" )
oCourierBold := HPDF_GetFont( oPdf, "Courier-Bold", "CP1252" )
      
aSetting := AutoDetect(cPRN)
If lLandScape = NIL
   If aSetting[1] > 134  // MaxCol portrait   80 normal, 134 condensed
      lLandScape := .T.  //        landscape 113 normal, 192 condensed
   Else
      lLandScape := .F.
   Endif
Endif
If lIsEpson = NIL
   If aSetting[2] = "E"
      lIsEpson := .T.
   Else
      lIsEpson := .F.
   Endif
Endif
If lIsEpson // EPSON print codes
   aESC := {CHR(27)+"W"+CHR(1),; // Expanded On
            CHR(27)+"W"+CHR(0),; // Expanded Off
			CHR(27)+"E",;        // Bold On 
			CHR(27)+"F",;        // Bold Off
            CHR(15),;            // Condensed On
			CHR(18),;            // Condensed Off
			CHR(27)+"0",;        // 8 lines per inch
			CHR(27)+"2"}         // 6 lines per inch
Else
   aESC := {CHR(27)+'(s12H',;    // Expanded On
            CHR(27)+'(s10H',;    // Expanded Off
			CHR(27)+'(s3B',;     // Bold On 
			CHR(27)+'(s-3B',;    // Bold Off
            CHR(27)+'(s16.67H',; // Condensed On,;
			CHR(27)+'(s10H',;    // Condensed Off
			CHR(27)+'(s1P',;     // 8 lines per inch
			CHR(27)+'(s0P'}      // 6 lines per inch
Endif

hFile := FOPEN( cPRN, 0 + 64 )
IF hFile <> - 1
   tamanho=FSeek(hFile,0,2)
   FSeek(hFile,0)
   
   oPage := HPDF_AddPage(opdf)
   HPDF_Page_SetSize(oPage, HPDF_PAGE_SIZE_A4, IF(lLandscape=.T.,HPDF_PAGE_LANDSCAPE,HPDF_PAGE_PORTRAIT) )
   nHigh := HPDF_Page_GetHeight( oPage )
   nLength := HPDF_Page_GetWidth( oPage )

   nRow := nHigh
   lFirst = .T.

   // Default values
   l8lp := .F.
   lCondensed = .F.
   lExpanded = .F.
   lBold = .F.

   DO WHILE .T.
      cLine := RDSTR( hFile,@cBuffer,@poz,2052 )
      IF lFirst = .T. //  Removing first character when comes with empty space
         lFirst := .F.
         cLine = SubStr(cLine,2)
      ENDIF
      IF LEN( cLine ) = 0
         EXIT
      ENDIF

      nCol = nMargem
      FOR nI=1 TO Len(cLine)
          cCaracter := SubStr(cLine,nI,1)
          nII = nI
          IF SubStr(cLine,nI,3)==aESC[1]      // Expanded On
             lExpanded := .T.
             nI += 3
          ELSEIF SubStr(cLine,nI,3)==aESC[2]  // Expanded Off
             lExpanded := .F.
             nI += 3
          ENDIF
          IF SubStr(cLine,nI,2)==aESC[3]      // Bold On 
             lBold := .T.
             nI += 2
          ELSEIF SubStr(cLine,nI,2)==aESC[4]  // Bold Off
             lBold := .F.
             nI += 2
          ENDIF
          IF SubStr(cLine,nI,1)==aESC[5]      // Condensed On
             lCondensed := .T.
             nI ++
          ELSEIF SubStr(cLine,nI,1)==aESC[6]  // Condensed Off
             lCondensed := .F.
             nI ++
          ENDIF
          IF SubStr(cLine,nI,2)==aESC[7]      // 8 lines per inch
             l8lp := .T.                       
             nI += 2                           
          ELSEIF SubStr(cLine,nI,2)==aESC[8]  // 6 lines per inch
             l8lp := .F.
             nI += 2
          ENDIF
          IF nII<>nI
             nI --
             LOOP
          ENDIF

          IF cCaracter=CHR(12)        // Form Feed (Eject)
			 If nPage <= aSetting[3]  // Removing last form feed to avoid empty page
			    If !lSilent
			       ? "Processing page "+AllTrim(Str(nPage))+"/"+AllTrim(Str(aSetting[3]))
				Endif
                oPage := HPDF_AddPage(opdf)
                HPDF_Page_SetSize(oPage, HPDF_PAGE_SIZE_A4, IF(lLandscape=.T.,HPDF_PAGE_LANDSCAPE,HPDF_PAGE_PORTRAIT) )
                nHigh := HPDF_Page_GetHeight( oPage )
                nLength := HPDF_Page_GetWidth( oPage )
                nRow := nHigh
				nPage := nPage +1
                EXIT
			 Endif
          ENDIF
         
		  nSize := 11
          nPitch := 7.43             // (595/80) proportion used
		  
		  If !lCondensed 
		     If (!lLandscape .and. aSetting[1] > 80) .or. (lLandscape .and. aSetting[1] > 113)
		        lCondensed := .T.
			 Endif
		  Endif
		  
          IF lCondensed = .T.
             nSize := nSize / 1.72
             nPitch := 4.30          // (595/134)
             IF lExpanded = .T.
                nSize := 11
                nPitch := 7.43       // (595/80)
             ENDIF
          ELSE   
             IF lExpanded = .T.
                nSize := nSize * 2
                nPitch := 14.87      // (595/40)
             ENDIF
          ENDIF
          
		  IF l8lp = .T.
             nLineSpacing = 9.5
          ELSE
             nLineSpacing = 12
          ENDIF   
            
          HPDF_Page_BeginText( oPage )
          IF lBold = .T.
             HPDF_Page_SetFontAndSize( oPage, oCourierBold, nSize )
          ELSE   
             HPDF_Page_SetFontAndSize( oPage, oCourier, nSize )
          ENDIF
          HPDF_Page_TextRect(oPage, nCol, nRow,nCol+nSize, nRow-nLineSpacing, HB_OEMTOANSI(cCaracter), HPDF_TALIGN_LEFT, NIL)
          HPDF_Page_EndText( oPage )
          nCol += nPitch
      NEXT
      nRow -= nLineSpacing
   ENDDO
   TRY
      HPDF_SaveToFile( oPdf, cPDFName )
   CATCH
      Hb_Alert("Problems when generating the PDF, try again. ")
   END
   Fclose( hFile )
ELSE
   Return .F.
ENDIF
Return .T.

Function RDSTR( han, strbuf, poz, buflen )  // HwGui function
Local stro := "", rez, oldpoz, poz1

oldpoz := poz
poz    := At( Chr( 10 ), SubStr( strbuf, poz ) )
IF poz = 0
   IF han <> Nil
      stro += SubStr( strbuf, oldpoz )
      rez  := FRead( han, @strbuf, buflen )
      IF rez = 0
         Return ""
      ELSEIF rez < buflen
         strbuf := SubStr( strbuf, 1, rez ) + Chr( 10 ) + Chr( 13 )
      ENDIF
      poz  := At( Chr( 10 ), strbuf )
      stro += SubStr( strbuf, 1, poz )
   ELSE
      stro += RTrim( SubStr( strbuf, oldpoz ) )
      poz  := oldpoz + Len( stro )
      IF Len( stro ) == 0
         Return ""
      ENDIF
   ENDIF
ELSE
   stro += SubStr( strbuf, oldpoz, poz )
   poz  += oldpoz - 1
ENDIF
poz ++
poz1 := Len( stro )
IF poz1 > 2 .AND. Right( stro, 1 ) $ Chr( 13 ) + Chr( 10 )
   IF SubStr( stro, poz1 - 1, 1 ) $ Chr( 13 ) + Chr( 10 )
      poz1 --
   ENDIF
   stro := SubStr( stro, 1, poz1 - 1 )
ENDIF
Return stro

Function AutoDetect(cPRN)
Local aLines := hb_ATokens( StrTran( hb_MemoRead( cPRN ), Chr( 13 ) ), Chr( 10 ) )
Local nLarg := 0 , nPages := 0 , cType := "", I, U, nLen := Len(aLines)
Local aEpson := {CHR(27)+"W"+CHR(1),CHR(27)+"W"+CHR(0),CHR(27)+"E",CHR(27)+"F",;
                 CHR(15),CHR(18),CHR(27)+"0",CHR(27)+"2"}
For I=1 To nLen
    If Len(aLines[I]) > nLarg
	   nLarg := Len(aLines[I])
	Endif
	If Chr(12) $ aLines[I]
	   nPages := nPages +1
	Endif
	If Empty(cType)
	   For U=1 To 8
	       If aEpson[U] $ aLines[I]
		      cType := "E"
			  U := 8
	       Endif
	   Next
	Endif
Next
If Right(aLines[nLen],1)==CHR(12) 
   nPages := nPages -1
Endif
Return {nLarg,cType,nPages}