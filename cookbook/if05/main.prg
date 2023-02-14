/*
Estruturas de controle de fluxo
*/
PROCEDURE Main
LOCAL nNota 

   // Recebe o valor da nota
   nNota := 0
   INPUT "Informe a nota do aluno : " TO nNota
   
   // Decide se foi aprovado ou n�o de acordo com a m�dia
   DO CASE
   CASE ( nNota > 10 ) .OR. ( nNota < 0 )
      ? "Valor inv�lido"
   CASE ( nNota >= 7 ) 
      ? "Aprovado"
   CASE ( nNota >= 5 )
      ? "Recupera��o"
   CASE ( nNota >= 0 )	  
      ? "Reprovado"   
   OTHERWISE
      ? "Valor inv�lido"   
   ENDCASE 	  
       
   
RETURN


