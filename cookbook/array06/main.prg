/*
http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=17476
*/
PROCEDURE Main
LOCAL a1 := a2 := {}  // Mesma refer�ncia
LOCAL a3 := {}


   AADD( a1 , 10 )
   AADD( a1 , { 20 , 30 } )
   AADD( a1 , 30 )
   
   AADD( a3 , 10 )
   AADD( a3 , { 20 , 30 } )
   AADD( a3 , 30 )
   
  
   ? "Compare arrays contents"
   ? "hb_valtoexp( a1 ) == hb_valtoexp( a3 )  :  ", hb_valtoexp( a1 ) == hb_valtoexp( a3 )
   ?
  
RETURN 



