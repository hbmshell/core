/*
Exemplos usando o operador "menor que" e "menor ou igual a"
Tabela de classifica��o de imposto de renda. 
Fonte : 
http://www.calcule.net/calculos.trabalhistas/tabela.imposto.de.renda.php

Entrada : Base de c�lculo
Sa�da : Informa se o valor � isento de imposto ou n�o.
*/
#define VALOR_MAXIMO_ISENTO 1903.98
PROCEDURE Main
LOCAL nSalario
   
   INPUT "Informe o valor do sal�rio : " TO nSalario
   
   IF nSalario <= VALOR_MAXIMO_ISENTO
      ? "Isento."
   ELSE
      ? "Voc� tem imposto a pagar."   
   ENDIF

RETURN
