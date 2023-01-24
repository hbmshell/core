/*
Atribuição IN LINE
*/
PROCEDURE Main
LOCAL a1 := a2 := {}  // Mesma referência
LOCAL a3 := {}

   ?
   ? "Vou preencher a1 e a3 com o mesmo conteúdo..."
   ?
   AADD( a1 , 10 )
   AADD( a1 , 20 )
   AADD( a1 , 30 )
   
   AADD( a3 , 10 )
   AADD( a3 , 20 )
   AADD( a3 , 30 )
   

   ? "a1 e a2 possuem a mesma referência, por isso säo iguais"
   ? "a1 == a2  :  ", a1 == a2 

   ? "a1 e a3 säo independentes, por isso näo säo iguais"
   ? "a1 == a3  :  ", a1 == a3 
       
   
RETURN 



