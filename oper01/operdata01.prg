/*
Operador de igualdade aplicado a um tipo de dado data

O programa emite um aviso se for o último dia para o envio de dados
Entrada : A data de hoje gerado por DATE()
Saída : Se hoje for o dia, então emite um aviso.
*/
#define DATA_LIMITE 0d20160901
PROCEDURE Main

   SET DATE BRITISH 
   ? "Hoje é " , DATE()
   ? "A data limite é ", DATA_LIMITE 
   // Note que essa rotina não tem dados de entrada 
   // gerados pelo usuário
   // pois o dia de hoje é informado por DATE()
   IF DATE() == DATA_LIMITE
      ? "Lembrete especial: hoje é o último dia para enviar"
      ?? " os dados do balanço patrimonial."
   ENDIF

RETURN
