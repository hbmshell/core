
PROCEDURE Main
LOCAL aLetras := { "A" , "B" , "C" , "D" , "E" , "F" , "G" }
LOCAL cElemento

   FOR EACH cElemento IN aLetras   
       ? cElemento:__enumindex , " ==> " 
       ?? cElemento:__enumvalue, " = " ,  cElemento
   NEXT
       
RETURN 






