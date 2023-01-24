/*
Outras soluções em : http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=17476
*/
PROCEDURE Main
LOCAL a1 := a2 := {}  // Mesma referência
LOCAL a3 := {}

   ?
   ? "Vou preencher a1 e a3 com o mesmo conteúdo..."
   ?
   AADD( a1 , 10 )
   AADD( a1 , { 20 , 30 } )
   AADD( a1 , 30 )
   
   AADD( a3 , 10 )
   AADD( a3 , { 20 , 30 } )
   AADD( a3 , 30 )
   

   ? "a1 e a2 possuem a mesma referência, por isso säo iguais"
   ? "a1 == a2  :  ", a1 == a2 

   ? "a1 e a3 säo independentes, por isso näo säo iguais"
   ? "a1 == a3  :  ", a1 == a3 
   
   ? "Agora vou comparar o conteúdo de a1 e a3 usando hb_valtoexp() ..."
   ? "hb_valtoexp( a1 ) == hb_valtoexp( a3 )  :  ", hb_valtoexp( a1 ) == hb_valtoexp( a3 )
   ?
   ? "Veja o que faz hb_valtoexp()"
   ? hb_valtoexp( a1 ) 
       
   
RETURN 



