/*
Estruturas de controle de fluxo
*/
PROCEDURE Main
LOCAL nNota 

   // Recebe o valor da nota
   nNota := 0
   INPUT "Informe a nota do aluno : " TO nNota
   
   // Decide se foi aprovado ou n�o de acordo com a m�dia
   IF ( nNota > 10 ) .OR. ( nNota < 0 )
      ? "Valor inv�lido"
   ELSEIF ( nNota >= 7 ) 
      ? "Aprovado"
   ELSEIF ( nNota >= 5 )
      ? "Recupera��o"
   ELSEIF ( nNota >= 0 )	  
      ? "Reprovado"   
   ELSE
      ? "Valor inv�lido"   
   ENDIF 	  
       
   
RETURN


