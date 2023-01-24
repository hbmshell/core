
PROCEDURE Main
LOCAL aNomes := { "Spence", "Thompson" }

   Test( aNomes[ 1 ] )
   ? aNomes[ 1 ] // Spence
   Test( @aNomes[ 1 ] )
   ? aNomes[ 1 ] // Outro qualquer      
   
   
RETURN 

PROCEDURE Test( cNome )

   cNome := "Outro qualquer" 

RETURN





