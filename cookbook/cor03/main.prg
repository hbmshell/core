/*
CORES
*/
PROCEDURE Main
LOCAL nOpc // Option selecte

                /*Padr�o (Standard) , Barras luminosas (light bars)*/
   SET COLOR TO "B/W, W+/B+"
   
   CLS
   
   @ 8,8 TO 16,25 DOUBLE
   
   @ 10,10 PROMPT "   Cadastros   " 
   @ 12,10 PROMPT "   Relatórios  " 
   @ 14,10 PROMPT "      Sair     " 
   MENU TO nOpc
   
   SWITCH nOpc
   CASE 1
      ? "Cadastros"
      EXIT
   CASE 2
      ? "Relatórios"
      EXIT
   CASE 0   
   CASE 3
   OTHERWISE
      ? "Sair"
   END   
      
      
   
   
RETURN