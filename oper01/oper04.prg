/*
Operadores relacionais
*/
REQUEST HB_CODEPAGE_PT850

PROCEDURE Main
LOCAL x, y // Valores num�ricos
LOCAL lResultado 

   hb_cdpSelect( "PT850" ) // Seleciona o suporte a UTF8 

   x := 10
   y := 20

   // Armazena o resultado da compara��o em lResultado
   lResultado := ( x < y ) 

   ? "x = ", x
   ? "y = ", y
   ? "O resultado de x < y � ", lResultado
   ? "A nega��o do resultado acima � ", .NOT. lResultado
   
              
RETURN


