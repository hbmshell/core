
PROCEDURE Main
LOCAL aLetras := { "A" , "B" , "C" , "D" , "E" , "F" , "G" }
LOCAL cElemento

   FOR EACH cElemento IN aLetras   
       ? hb_valtoexp( cElemento:__enumbase )
   NEXT
       
RETURN 






