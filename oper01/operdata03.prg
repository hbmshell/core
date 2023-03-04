/*
Operador de igualdade aplicado a um tipo de dado data


Entrada : A data de hoje gerado por DATE()
Sa�da : Se hoje for o dia ou for menor, ent�o emite um aviso.
*/
#define DATA_LIMITE 0d20160915
PROCEDURE Main

   SET DATE BRITISH 
   ? "Hoje � " , DATE()
   ? "A data limite � ", DATA_LIMITE 
   // Note que essa rotina n�o tem dados de entrada 
   // gerados pelo usu�rio
   // pois o dia de hoje � informado por DATE()
   IF DATE() > DATA_LIMITE
      ? "Urgente!!! Passou do prazo de envio dos dados"
   ELSEIF DATE() < DATA_LIMITE
      ? "Est� chegando perto do dia limite"   
   ELSEIF DATE() == DATA_LIMITE
      ? "Lembrete especial: hoje � o �ltimo dia para enviar"
      ?? " os dados do balan�o patrimonial."
   ENDIF

RETURN
