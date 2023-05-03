/*
Thanks 
Bernard Mouille

https://groups.google.com/g/harbour-users/c/A2n_pxZ5jiI

hbmk2 main.prg hbwin.hbc
*/

// Puts a Word file images and graphs ( InlineShapes ) to a new Word file.
// Compile with -lhbwin
#define msoLinkedPicture   11   // Linked picture.
#define msoPicture         13   // Picture.
#define wdDoNotSaveChanges  0   // Do not save pending changes.
procedure Main
   local oWord
   local oDoc
   local oImgs
   local oShape
   local Word_File := win_GetOpenFileName( , "Select a Word file",,, { "Word files ; *.docx" } )
   if .not. file( Word_File )
      wapi_MessageBox( 0, "Word file not found, abort." )
      return
   endif
   setmode( 43, 80 )
   oWord         := Win_OleCreateObject( "Word.Application" )
   oWord:Visible := .T.
   oDoc          := oWord:documents:open( Word_File,, .T. )
   if oDoc:Shapes:Count > 0
      for each oShape in oDoc:Shapes
         if oShape:Type == msoLinkedPicture .or. oShape:Type == msoPicture
            oShape:ConvertToInlineShape()
         endif
      endfor
   endif
   if oDoc:InlineShapes:Count > 0
      oImgs := oWord:Documents:Add()
      for each oShape in oDoc:InlineShapes
         oShape:Range:CopyAsPicture()
         oImgs:Paragraphs:Add()
         oWord:Selection:Paste()
         oImgs:Paragraphs:Add()
      endfor
   endif
   oDoc:Close( wdDoNotSaveChanges )
   oWord := nil
   return