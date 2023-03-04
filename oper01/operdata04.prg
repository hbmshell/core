/*
Operador de igualdade aplicado a um tipo de dado data


Entrada : A data de hoje gerado por DATE()
Saída : Se hoje for o dia ou for menor, então emite um aviso.
*/
#define DATA_LIMITE 0d20160915
#define DIAS_AVISO 10 // Emitir o aviso com 10 dias ou menos
PROCEDURE Main

   SET DATE BRITISH 
   ? "Hoje é " , DATE()
   ? "A data limite é ", DATA_LIMITE 
   // Note que essa rotina não tem dados de entrada 
   // gerados pelo usuário
   // pois o dia de hoje é informado por DATE()
   IF DATE() > DATA_LIMITE
      ? "Urgente!!! Passou do prazo de envio dos dados"
   ELSEIF DATE() < DATA_LIMITE
      IF ( DATA_LIMITE - DATE() ) < 10
         ? "Está chegando perto do dia limite"   
      ENDIF   
   ELSEIF DATE() == DATA_LIMITE
      ? "Lembrete especial: hoje é o último dia para enviar"
      ?? " os dados do balanço patrimonial."
   ENDIF

RETURN
