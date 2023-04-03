/*
Adaptado de : http://www.pctoledo.com.br/forum/viewtopic.php?f=1&t=14710
*/
PROCEDURE Main

   LOCAL objLocal, bLastHandler, a := 0

   // Altera o error handler padr�o... / Change default error handler
   bLastHandler := ERRORBLOCK({ |objErr| Break(objErr) })
   
   BEGIN SEQUENCE
           
      ? a = a + "10" // <-- erro aqui / error here
           
   RECOVER USING objLocal
      
      ? "action to error recover"

   END
   
   // Restore previous error handler   / Restaura o error handler anterior (ErrorSys
   ERRORBLOCK( bLastHandler )          
   
RETURN 


