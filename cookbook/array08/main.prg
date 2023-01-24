/*
Exemplo retirado de : Clipper 5.2 - Rick Spence , p.159
*/
PROCEDURE Main
LOCAL aNomes := { "Spence", "Thompson" }

   Test( aNomes )
   ? aNomes[ 1 ] // Spence      
   
   
RETURN 

PROCEDURE Test( aFormal )

   ? aFormal[1] // Spence
   aFormal := { "Rick" , "Malcolm" }

RETURN





