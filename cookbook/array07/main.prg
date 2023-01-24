PROCEDURE Main
LOCAL a1 := { 10, 20, 30 }

   ? "O primeiro elemento é ", a1[ 1 ]

   Muda( a1 )
   
   ? "O primeiro elemento foi alterado : ", a1[ 1 ]
       
   
   
RETURN 

PROCEDURE Muda( aArray )

   aArray[ 1 ] := "Mudei aqui"

RETURN



