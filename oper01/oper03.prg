/*
Operadores relacionais: um resumo.
*/
PROCEDURE Main
LOCAL x, y // Valores numéricos
LOCAL dData1, dData2 // Datas
LOCAL cString1, cString2 // Caracteres

   SET DATE BRIT // Data dd/mm/aa
   SET CENTURY ON // Ano com 4 dígitos

   ? "Comparando variáveis numéricas"   
   ?
   x := 2
   y := 3
   ? 'x := 2'
   ? 'y := 3'
   ? "x > y : " , x > y // Retorna falso (.f.)
   ? "y = 3 : " , y = 3 // Retorna verdadeiro (.t.)
   ? "y <> x : ", y <> x // Retorna verdadeiro (.t.)
   ?
   ? "Comparando datas"
   ?
   dData1 := CTOD("01/09/2015")
   dData2 := CTOD("02/09/2015")
   ? 'dData1 := CTOD("01/09/2015")'
   ? 'dData2 := CTOD("02/09/2015")'
   ? "dData1 >= dData2 : ", dData1 >= dData2 // Retorna falso (.f.)
   ? "( dData1 + 1 ) = dData2 : ", ( dData1 + 1 ) = dData2 // Retorna verdadeiro (.t.)
   ?
   ? "Comparando strings"
   ?
   cString1 := "Vlademiro"
   cString2 := "Vlad"   
   
   ? 'cString1 := "Vlademiro"'
   ? 'cString2 := "Vlad"'
   
   ?  " cString1 == cString2 : " , cString1 == cString2 // .f.
   
   /* Cuidado !! */
   /* Leia com atenção o tópico sobre comparação de strings */
   ?  "Cuidado !! com a comparaçäo abaixo. Ela é confusa por causa do =."
   ?  " cString1 = cString2 : " , cString1 = cString2  // .t. 
   ?  "Use sempre o operador == no lugar de ="
              
RETURN


