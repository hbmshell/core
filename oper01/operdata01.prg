/*
Operador de igualdade aplicado a um tipo de dado data

O programa emite um aviso se for o �ltimo dia para o envio de dados
Entrada : A data de hoje gerado por DATE()
Sa�da : Se hoje for o dia, ent�o emite um aviso.
*/
#define DATA_LIMITE 0d20160901
PROCEDURE Main

   SET DATE BRITISH 
   ? "Hoje � " , DATE()
   ? "A data limite � ", DATA_LIMITE 
   // Note que essa rotina n�o tem dados de entrada 
   // gerados pelo usu�rio
   // pois o dia de hoje � informado por DATE()
   IF DATE() == DATA_LIMITE
      ? "Lembrete especial: hoje � o �ltimo dia para enviar"
      ?? " os dados do balan�o patrimonial."
   ENDIF

RETURN
