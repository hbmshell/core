
PROCEDURE Main
LOCAL aLetras := { "A" , "B" , "C" , "D" , "E" }
LOCAL cElemento

   ?
   ? "Os elementos originais"
   FOR EACH cElemento IN aLetras   
       ? cElemento
   NEXT
   ?
   ? "Diminuindo o tamanho para 3 elementos"
   aLetras := ASIZE( aLetras, 3 )
   FOR EACH cElemento IN aLetras   
       ? cElemento
   NEXT
   ?
   ? "Aumentando o tamanho para 5 elementos"
   aLetras := ASIZE( aLetras, 5 )
   FOR EACH cElemento IN aLetras   
       ? cElemento
   NEXT
   
       
RETURN 






