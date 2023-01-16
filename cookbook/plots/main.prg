#!/workspace/hbmshell/hbmshell --dialog
//-q0

* Exemplo de rotina para ajustar valor da ultima parcela quando o valor
* das mesmas trata-se de uma dizima periodica
* Por exemplo: R$100,00 dividido em 3 parcelas gera 3 parcelas de 
*              R$33,33333333....
*
* Compilar: 
*          Clipper parcelas
*          Blinker fi parcelas
*
* toya - 14/11/2003
* http://www.toyanet.com.br
* toyasis@yahoo.com.br
*
FUNCTION hb_MAIN
Clea
aParcelas := {}
n := 0.00
p := 0

@ 02,00 Say 'Total value: ' Get n Picture '999999.99'
@ 03,00 Say 'Plots : 'Get p Picture '99'
Read
If LastKey() == 27 .Or. Empty(n) .Or. Empty(p)
   Quit
EndIf   
aParcelas := MontaParcelas(n,p)
Clea
For i=1 to p
  ? 'Plot '+Str(i,2)+ ': '+ Str(aParcelas[i],9,2)
Next
?

Return  

* -----------------------------------------------------------------------------
Function MontaParcelas(Arg1,Arg2)
* -----------------------------------------------------------------------------
* Arg1 := montante da divida
* Arg2 := quantidade de parcelas
*
Local Local1
If Arg2 < 2
   Return {Arg1}
EndIf
Local1 := Array(Arg2)
Afill(Local1,Round(Arg1/Arg2,2))
Local1[Arg2] := Arg1 - (Local1[1] * (Arg2-1))
Return Local1
