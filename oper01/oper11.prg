/*
Operador de diferença

Entrada : A resposta a pergunta 
Saída : Informa se o valor é correto ou não.
*/
#define RESPOSTA 10
PROCEDURE Main
LOCAL nResposta
   
   INPUT "Informe quanto é 5 + 5 : " TO nResposta
   
   IF nResposta <> RESPOSTA 
      ? "Resposta está errada."
   ELSE
      ? "Certa a resposta."   
   ENDIF

RETURN
