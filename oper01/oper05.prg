
/*
Atribui��o de dados a vari�veis
*/
REQUEST HB_CODEPAGE_PT850

PROCEDURE Main
LOCAL x, y // Valores num�ricos


   hb_cdpSelect( "PT850" ) // Seleciona o suporte a UTF8 
   ? "Opera��o convencional de atribui��o"
   x := 10
   y := 20
   ? "x = ", x
   ? "y = ", y
   ?   
   ? "Opera��o em linha de atribui��o"
   x := y := 10
   ? "x = ", x
   ? "y = ", y
   ?
   y := x * 2   
   x := "Agora x � caracter"
   ? "x = ", x
   ? "y = ", y
   ?   

              
RETURN


