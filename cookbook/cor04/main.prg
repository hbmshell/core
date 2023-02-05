/*
SETCOLOR
*/
PROCEDURE Main
LOCAL cOldColor 
           
   
   CLS
   ? "The current colors :"
   ? SETCOLOR()
   ? "   .............."
   ? "   White and black"
   ? "   .............."
   ? "Change color now:"
   cOldColor := SETCOLOR( "N/G" ) 
   ? "   .............."
   ? "   Black and green "
   ? "   .............."
   ?
   ? "   Old color is : " + cOldColor
   ? "   Go back to her..."
   SetColor( cOldColor )
   ? "   .............."
   ? "   Again       "
   ? "   White and black"
   ? "   .............."
   ?
   ?
   
RETURN