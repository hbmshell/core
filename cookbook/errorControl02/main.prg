/*
Erro de linkedição
Mais no fórum : http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=17511
*/
PROCEDURE Main
LOCAL a := 0

   BEGIN SEQUENCE WITH __BreakBlock()
           
      a = a + "10" // <-- error here 
           
   RECOVER 
         
      ? "Recover"

   END
   
   
RETURN 


