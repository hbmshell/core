
PROCEDURE Main
LOCAL aLetras := { "A" , "B" , "C" , "D" , "E" }
LOCAL cElemento

   ?
   ? "Originals"
   FOR EACH cElemento IN aLetras   
       ? cElemento
   NEXT
   ?
   ? "Change to 3 elements"
   aLetras := ASIZE( aLetras, 3 )
   FOR EACH cElemento IN aLetras   
       ? cElemento
   NEXT
   ?
   ? "Change to 5 elements"
   aLetras := ASIZE( aLetras, 5 )
   FOR EACH cElemento IN aLetras   
       ? cElemento
   NEXT
   
       
RETURN 






