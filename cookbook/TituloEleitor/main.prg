
PROCEDURE MAIN

	? cTit := "890654", TestaTitulo( cTit )
	? cTit := "004356870906" , TestaTitulo( cTit )

RETURN


/**
* Função para validar Título Eleitoral
*
*/
Function TestaTitulo(pTitulo)
Local digito1 := 0
Local digito2 := 0
Local decr1 := 9
Local i := 0
Local j := 0
Local cTitulo := StrZero(Val(pTitulo),12)

If !Empty(pTitulo) .AND. pTitulo != '000000000000' 

   For i:=1 To 8
       digito1 := (digito1 + Val(SubStr(cTitulo,i,1)) * decr1)
       decr1:= (decr1 - 1)
   Next

   digito1 := digito1% 11

   If digito1 == 0  .or. digito1 == 1
      If Val(substr(cTitulo,9,1))== 0 .and. (Val(SubStr(cTitulo,10,1)) == 1 .or. Val(SubStr(cTitulo,10,1)) == 2)
         If digito1 = 0
            digito1 := 1 
         Else 
                      digito1 := 0
         Endif
      Else 
         digito1 := 0 
      EndIf
   else 
      digito1 := (11 - digito1)
   EndIf

   If (digito1 = Val(SubStr(cTitulo,11,1))) 
      j := 1
   Else 
      j := 0
   EndIf
   If (j = 1)
      digito2 := (Val(SubStr(cTitulo,9,1))*4) + (Val(SubStr(cTitulo,10,1))*3) + (digito1*2)
      digito2 := digito2 % 11
      If ((digito2 = 0 ) .or. (digito2 = 1))
         If (Val(SubStr(cTitulo,9,1))= 0 .and. (Val(SubStr(cTitulo,10,1)) = 1 .or. Val(SubStr(cTitulo,10,1)) = 2))
            If digito2 = 0
               digito2 := 1 
            Else 
                              digito2 := 0
            EndIf
         Else
                      digito2 := 0 
         EndIf
      Else 
              digito2 := (11 - digito2)
      Endif
   
           If (digito2 <> Val(substr(cTitulo,12,1)))
         j := 0
      Else 
              j := 1
      EndIf
   Endif   
EndIf

If (j = 1)
  If Empty(pTitulo) .or. pTitulo == '000000000000' 
     Return .F.
  Else 
     Return .T.
  Endif   
Else
   Return .F.  
EndIf 

Return .T. 
