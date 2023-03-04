/*
Incremento e decremento
*/
PROCEDURE Main
LOCAL nNum1 , nNum2  // Valores numéricos

   
   // Operador de pré-incremento ++
   nNum1 := 0
   nNum2 := ++nNum1
   ? nNum1 // Vale 1
   ? nNum2 // Vale 1

   // Operador de pós-incremento ++   
   //inicio
   nNum1 := 0
   nNum2 := nNum1++
   ? nNum1 // Vale 1
   ? nNum2 // Vale 0 
   //fim
  
   // Operador de pré-decremento --
   nNum1 := 1
   nNum2 := --nNum1
   ? nNum1 // Vale 0
   ? nNum2 // Vale 0

   // Operador de pós-decremento --
   //inicio
   nNum1 := 1
   nNum2 := nNum1--
   ? nNum1 // Vale 0
   ? nNum2 // Vale 1
   //fim
   
   // Os dois operadores em conjunto
   //inicio
   nNum1 := 1
   nNum2 := 5
   ? nNum1-- * 2 + ( ++nNum2 ) // Mostra 8
   // O cálculo efetuado foi :
   // 1 * 2 + 6
   // Mostra 8
   ? nNum1 // Vale 0
   ? nNum2 // Vale 6
   //fim     
   
RETURN


