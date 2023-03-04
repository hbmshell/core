/*
Exemplos usando o operador "maior que" e "maior ou igual a"
Taxação extra sobre conta de luz. 

Entrada : O consumo de energia 
Saída : Informa se o valor é taxado ou não.
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
