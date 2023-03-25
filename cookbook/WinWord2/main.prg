/*
Thanks 
Bernard Mouille

https://groups.google.com/g/harbour-users/c/A2n_pxZ5jiI

hbmk2 main.prg hbwin.hbc
*/

#define Word_File  hb_cwd() + "MyFileTxt.docx"
procedure Main
   local oWord
   local oDoc
   local oImgs
   local i
   oWord         := Win_OleCreateObject( "Word.Application" )
   oWord:Visible := .T.
   oDoc          := oWord:documents:open( Word_File )
   if oDoc:Content:InlineShapes:Count > 0
      oImgs := oWord:Documents:Add()
      for i := 1 To oDoc:Content:InlineShapes:Count
         oDoc:Content:InlineShapes( i ):Range:CopyAsPicture()
         oImgs:Paragraphs:Add()
         oWord:Selection:Paste()
      endfor
    endif
   oWord := NIL
   return