/*
Operador de diferen�a

Entrada : A resposta a pergunta 
Sa�da : Informa se o valor � correto ou n�o.
*/
#define RESPOSTA 10
PROCEDURE Main
LOCAL nResposta
   
   INPUT "Informe quanto � 5 + 5 : " TO nResposta
   
   IF nResposta <> RESPOSTA 
      ? "Resposta est� errada."
   ELSE
      ? "Certa a resposta."   
   ENDIF

RETURN
