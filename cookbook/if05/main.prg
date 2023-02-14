/*
Estruturas de controle de fluxo
*/
PROCEDURE Main
LOCAL nNota 

   // Recebe o valor da nota
   nNota := 0
   INPUT "Informe a nota do aluno : " TO nNota
   
   // Decide se foi aprovado ou não de acordo com a média
   DO CASE
   CASE ( nNota > 10 ) .OR. ( nNota < 0 )
      ? "Valor inválido"
   CASE ( nNota >= 7 ) 
      ? "Aprovado"
   CASE ( nNota >= 5 )
      ? "Recuperaçäo"
   CASE ( nNota >= 0 )	  
      ? "Reprovado"   
   OTHERWISE
      ? "Valor inválido"   
   ENDCASE 	  
       
   
RETURN


