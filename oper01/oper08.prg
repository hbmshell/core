/*
Exemplos usando o operador "menor que" e "menor ou igual a"
Tabela de classificação de imposto de renda. 
Fonte : 
http://www.calcule.net/calculos.trabalhistas/tabela.imposto.de.renda.php

Entrada : Base de cálculo
Saída : Informa se o valor é isento de imposto ou não.
*/
#define VALOR_MAXIMO_ISENTO 1903.98
PROCEDURE Main
LOCAL nSalario
   
   INPUT "Informe o valor do salário : " TO nSalario
   
   IF nSalario <= VALOR_MAXIMO_ISENTO
      ? "Isento."
   ELSE
      ? "Você tem imposto a pagar."   
   ENDIF

RETURN
