/*
CORES
*/
PROCEDURE Main
LOCAL cProjeto := "SISTEMA PARA CONTROLE DE FROTAS     "
LOCAL cResponsavel := SPACE(20)
LOCAL nValor := 0
LOCAL GetList := {}
                /*Padr�o , Get ativo,,, Get Inativo*/
   SET COLOR TO "BG+/N, N/W,,,W+/GR+"
   
   CLS
   
   @ 8,8 TO 16,75 DOUBLE
   
   SET DELIMITERS ON
   SET DELIMITERS TO "[]"

   @ 10,10 SAY "Nome do projeto     : " GET cProjeto PICTURE "@K"
   @ 12,10 SAY "Nome do respons�vel : " GET cResponsavel
   @ 14,10 SAY "Valor do projeto    : " GET nValor PICTURE "@E 999,999.99"   
   READ
   
   
RETURN