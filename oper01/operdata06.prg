/*
Operador de diferença aplicado a um tipo de dado data
*/
#define DATA_DA_OPERACAO 0d20170715
PROCEDURE Main

   SET DATE BRITISH 
   ? "Hoje é " , DATE()
   ? "A data da operaçäo é ", DATA_DA_OPERACAO 
   // Note que essa rotina não tem dados de entrada 
   // gerados pelo usuário
   // pois o dia de hoje é informado por DATE()
   IF DATE() <> DATA_DA_OPERACAO
      ? "Aviso importante!! Essa operaçäo näo pode ser realizada hoje."
   ELSE
      ? "Rotina especial sendo executada agora"
      // Segue o hipotético código a ser executado
      ? "Operaçäo finalizada"
   ENDIF

RETURN
