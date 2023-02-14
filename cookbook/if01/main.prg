/*
Estruturas de controle de fluxo
*/
PROCEDURE Main
LOCAL nNota 

   // Recebe o valor da nota
   nNota := 0
   INPUT "Informe a nota do aluno : " TO nNota
   
   // Decide se foi aprovado ou não de acordo com a média
   IF ( nNota >= 7 )
      ? "Aprovado"
   ENDIF 	  
       
   
RETURN


