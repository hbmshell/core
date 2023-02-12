#define DMPAPER_A5                  11    && A5 148X210mm
#define DMPAPER_A5_TRANSVERSE       61    && A5 Transverse 148 x 210 mm
*
*
*
*------------------------------------------------------------------------------
FUNCTION Main()
*
LOCAL nPrn:=1
LOCAL aPrn:= GetPrinters()
Clear
*
IF EMPTY( aPrn )
   Alert( 'Nenhuma impressora instalada' )
   QUIT
END
*
Clear
*
WHILE ! EMPTY( nPrn )
   Clear
   @ 00,00 SAY 'Teste de uso do WIN32PRN'
   @ 01,00 TO maxRow(),maxCol()
   nPrn := ACHOICE( 02, 01, maxRow()-1, maxCol()-1, aPrn, .T., , nPrn )
   *
   IF ! EMPTY( nPrn )
      PrnTest( aPrn[nPrn] )
   ELSE

   ENDIF
   *
ENDDO
*
@ 22,00 say ""
*
RETURN( NIL )
*
*
*
*------------------------------------------------------------------------------
FUNCTION PrnTest(cPrinter)
*
LOCAL oPrinter     := WIN32PRN():New(cPrinter), aFonts, nPos
oPrinter:Landscape := .F.
oPrinter:FormType  := DMPAPER_A5_TRANSVERSE
oPrinter:Copies    := 1
*
IF ! oPrinter:Create()
   Alert('Erro criando a impressora')
ELSE
   *
   IF !oPrinter:startDoc('Isto ir  aparecer no SPOOLER do windows')
      Alert('Erro iniciando documento.')
   ELSE
      oPrinter:UnderLine( .F. )
      oPrinter:SetFont( 'Courier New',10,{1,20}, 0, .F., .F. )
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -altura da linha', .T. )
      *
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '===============================================================================', .T. )
      *
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -altura atual da linha', .T. )
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -alterando altura da linha para 50', .T. )
      oPrinter:LineHeight( 50 )
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -altura da linha alterada', .T. )
      *
      oPrinter:TextOut( '===============================================================================', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '===============================================================================', .T. )
      *
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -altura atual da linha', .T. )
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -alterando altura da linha para 150', .T. )
      oPrinter:LineHeight( 150 )
      oPrinter:Textout( STR( oprinter:LineHeight()    ) + '  -altura da linha alterada', .T. )
      *
      oPrinter:TextOut( '===============================================================================', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '1234567890123456789012345678901234567890', .T. )
      oPrinter:TextOut( '===============================================================================', .T. )
      *
      oPrinter:EndDoc()
      oPrinter:Destroy()
   ENDIF
   *
ENDIF
*
RETURN(NIL)