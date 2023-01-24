/*
Atribui��o IN LINE
*/
PROCEDURE Main
LOCAL a1 := a2 := {}  // Same reference (This is equuals)
LOCAL a3 := {}

   ?
   ? "I will fill a1 and a3 with same content."
   ?
   AADD( a1 , 10 )
   AADD( a1 , 20 )
   AADD( a1 , 30 )
   
   AADD( a3 , 10 )
   AADD( a3 , 20 )
   AADD( a3 , 30 )
   

   ? "a1 and a2 has same reference. a1 = a2"
   ? "a1 == a2  :  ", a1 == a2 

   ? "a1 and a3 doestn't has the same reference. It is independents. a1 <> a2"
   ? "a1 == a3  :  ", a1 == a3 
       
   
RETURN 



