
// The example implements a simple text file viewer using a
// TBrowse object and text file functions.


PROCEDURE Main( cFile )
   LOCAL nFile, oTBrowse

   SET CURSOR OFF
   nFile := FT_FUse( cFile )

   IF nFile < 1
      ? "File not found", cFile
      QUIT
   ENDIF

   oTBrowse := TxtBrowse()

   RunTxtBrowse( oTBrowse )

   FT_FUse()
RETURN

PROCEDURE RunTxtBrowse( oTBrowse )
   LOCAL nKey, nLen, lRun := .T.

   DO WHILE lRun
      oTBrowse:forceStable()
      nKey := Inkey(0)

      SWITCH nKey
      CASE K_LEFT
         IF oTBrowse:cargo > 1
            oTBrowse:cargo --
            oTBrowse:refreshAll()
         ENDIF
         EXIT

      CASE K_RIGHT
         oTBrowse:cargo ++
         oTBrowse:refreshAll()
         EXIT

      CASE K_HOME
         IF oTBrowse:cargo > 1
            oTBrowse:cargo := 1
            oTBrowse:refreshAll()
         ENDIF
         EXIT

      CASE K_END
         nLen := Len( FT_FReadLN() )
         IF nLen-oTBrowse:cargo+1 > 72
            oTBrowse:cargo := nLen - 72 + 1
            oTBrowse:refreshAll()
         ENDIF
         EXIT

      CASE K_CTRL_HOME
         EXIT

      CASE K_CTRL_END
         EXIT

      OTHERWISE
         IF oTBrowse:applyKey( nKey ) == TBR_EXIT
            lRun := .F.
         ENDIF
      END
   ENDDO
RETURN

FUNCTION TxTBrowse( nT, nL, nB, nR )
   LOCAL oTBrowse, oTBCol1, oTBCol2

   FT_Default( @nT , 0) 
   FT_Default( @nL , 0)
   FT_Default( @nB, MaxRow() )
   FT_Default( @nR, MaxCol() )
           
   oTBrowse := TBrowseNew( nT, nL, nB, nR )
   oTBrowse:cargo := 1

   oTBCol1  := TBColumnNew( " ",  ;
                           {|| Padr(FT_FRecno(),5)+":" } )

   oTBCol2  := TBColumnNew( " ",  ;
                           {|| Padr( SubStr( FT_FReadLN(), oTBrowse:cargo), 72 ) } )

   WITH OBJECT oTBrowse
      :addColumn( oTbCol1 )
      :addColumn( oTbCol2 )

      :goTopBlock    := {|| FT_FGotop() }
      :goBottomBlock := {|| FT_FGoBottom() }
      :skipBlock     := {|n| TxtSkipper(n) }
      :colPos        := 2
   END

RETURN oTBrowse

FUNCTION TxtSkipper( nRequest )
   LOCAL nSkip := 0

   DO CASE
   CASE nRequest == 0
   CASE nRequest < 0

      DO WHILE nSkip > nRequest .AND. FT_FRecno() > 1
         FT_FSkip(-1)
         nSkip --
      ENDDO

   CASE nRequest > 0
      DO WHILE nSkip < nRequest
         FT_FSkip(1)
         IF FT_FEof()
            EXIT
         ENDIF
         nSkip ++
      ENDDO
   ENDCASE

RETURN nSkip
