/*
Operador de diferen�a aplicado a um tipo de dado data
*/
#define DATA_DA_OPERACAO 0d20170715
PROCEDURE Main

   SET DATE BRITISH 
   ? "Hoje � " , DATE()
   ? "A data da opera��o � ", DATA_DA_OPERACAO 
   // Note que essa rotina n�o tem dados de entrada 
   // gerados pelo usu�rio
   // pois o dia de hoje � informado por DATE()
   IF DATE() <> DATA_DA_OPERACAO
      ? "Aviso importante!! Essa opera��o n�o pode ser realizada hoje."
   ELSE
      ? "Rotina especial sendo executada agora"
      // Segue o hipot�tico c�digo a ser executado
      ? "Opera��o finalizada"
   ENDIF

RETURN
