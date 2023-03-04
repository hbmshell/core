/*
Operadores relacionais
*/
REQUEST HB_CODEPAGE_PT850

PROCEDURE Main
LOCAL x, y // Valores numéricos
LOCAL lResultado 

   hb_cdpSelect( "PT850" ) // Seleciona o suporte a UTF8 

   x := 10
   y := 20

   // Armazena o resultado da comparação em lResultado
   lResultado := ( x < y ) 

   ? "x = ", x
   ? "y = ", y
   ? "O resultado de x < y é ", lResultado
   ? "A negação do resultado acima é ", .NOT. lResultado
   
              
RETURN


