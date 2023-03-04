/*
Operadores de strings + e -

Note que todas as strings tem, propositadamente, um
espaço em branco no seu início e outro no seu final.

*/
PROCEDURE Main
LOCAL cPre , cPos 
LOCAL cNome 

   cPre := "    Harbour     " // String tamanho 16
   cPos := "    Project     " // String tamanho 16

   ? "Exemplo 1 : Concatenando com +"
   ? cPre + cPos
   ?? "X" // Vai ser impresso  após o término da linha acima
   ? "O tamanho da string acima é de " , Len( cPre + cPos ) 
   ?
   ? "Exemplo 2 : Concatenando com -"
   ? cPre - cPos
   ?? "X" // Vai ser impresso  após o término da linha acima
   ? "O tamanho da string acima é de " , Len( cPre - cPos )  

   //inicio
   cNome := " (www.harbour-project.org) "
   ?
   ? "Exemplo 3 : Concatenando três strings com +"
   ? cPre + cPos + cNome
   ?? "X" // Vai ser impresso  após o término da linha acima
   ? "O tamanho da string acima é de " , Len( cPre + cPos + cNome)  
   ?
   ? "Exemplo 4 : Concatenando três strings com -"
   ? cPre - cPos - cNome
   ?? "X" // Vai ser impresso  após o término da linha acima
   ? "O tamanho da string acima é de " , Len( cPre - cPos - cNome) 
   //fim

RETURN

