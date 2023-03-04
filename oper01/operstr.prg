/*
Operadores de strings + e -

Note que todas as strings tem, propositadamente, um
espa�o em branco no seu in�cio e outro no seu final.

*/
PROCEDURE Main
LOCAL cPre , cPos 
LOCAL cNome 

   cPre := "    Harbour     " // String tamanho 16
   cPos := "    Project     " // String tamanho 16

   ? "Exemplo 1 : Concatenando com +"
   ? cPre + cPos
   ?? "X" // Vai ser impresso  ap�s o t�rmino da linha acima
   ? "O tamanho da string acima � de " , Len( cPre + cPos ) 
   ?
   ? "Exemplo 2 : Concatenando com -"
   ? cPre - cPos
   ?? "X" // Vai ser impresso  ap�s o t�rmino da linha acima
   ? "O tamanho da string acima � de " , Len( cPre - cPos )  

   //inicio
   cNome := " (www.harbour-project.org) "
   ?
   ? "Exemplo 3 : Concatenando tr�s strings com +"
   ? cPre + cPos + cNome
   ?? "X" // Vai ser impresso  ap�s o t�rmino da linha acima
   ? "O tamanho da string acima � de " , Len( cPre + cPos + cNome)  
   ?
   ? "Exemplo 4 : Concatenando tr�s strings com -"
   ? cPre - cPos - cNome
   ?? "X" // Vai ser impresso  ap�s o t�rmino da linha acima
   ? "O tamanho da string acima � de " , Len( cPre - cPos - cNome) 
   //fim

RETURN

