PROCEDURE Main
LOCAL a1 := { 10, 20, 30 }

   ? "First element ", a1[ 1 ]

   Muda( a1 )
   
   ? "The first element has changed : ", a1[ 1 ]
       
   
   
RETURN 

PROCEDURE Muda( aArray )

   aArray[ 1 ] := "Change it here"

RETURN



