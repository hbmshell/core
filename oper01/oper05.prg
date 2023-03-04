
/*
Atribuição de dados a variáveis
*/
REQUEST HB_CODEPAGE_PT850

PROCEDURE Main
LOCAL x, y // Valores numéricos


   hb_cdpSelect( "PT850" ) // Seleciona o suporte a UTF8 
   ? "Operação convencional de atribuição"
   x := 10
   y := 20
   ? "x = ", x
   ? "y = ", y
   ?   
   ? "Operação em linha de atribuição"
   x := y := 10
   ? "x = ", x
   ? "y = ", y
   ?
   y := x * 2   
   x := "Agora x é caracter"
   ? "x = ", x
   ? "y = ", y
   ?   

              
RETURN


