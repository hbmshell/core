/*
Exemplos usando o operador "maior que" e "maior ou igual a"
Taxa��o extra sobre conta de luz. 

Entrada : O consumo de energia 
Sa�da : Informa se o valor � taxado ou n�o.
*/
#define VALOR_MAXIMO_ISENTO 2400
PROCEDURE Main
LOCAL nConsumo
   
   INPUT "Informe o valor do consumo de energia : " TO nConsumo
   
   IF nConsumo > VALOR_MAXIMO_ISENTO 
      ? "Vai pagar taxa adicional."
   ELSE
      ? "Isento de taxas adicionais."   
   ENDIF

RETURN
