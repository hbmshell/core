/*
Atribui��o IN LINE
*/
PROCEDURE Main
LOCAL a1 := a2 := {}  // Mesma refer�ncia
LOCAL a3 := {}

   ?
   ? "Vou preencher a1 e a3 com o mesmo conte�do..."
   ?
   AADD( a1 , 10 )
   AADD( a1 , 20 )
   AADD( a1 , 30 )
   
   AADD( a3 , 10 )
   AADD( a3 , 20 )
   AADD( a3 , 30 )
   

   ? "a1 e a2 possuem a mesma refer�ncia, por isso s�o iguais"
   ? "a1 == a2  :  ", a1 == a2 

   ? "a1 e a3 s�o independentes, por isso n�o s�o iguais"
   ? "a1 == a3  :  ", a1 == a3 
       
   
RETURN 



