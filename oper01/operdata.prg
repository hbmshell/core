/*
Vari�vel Data e operadores += e -=
*/
PROCEDURE Main
LOCAL dVenc // Data de vencimento
   SET DATE BRITISH
   dVenc := CTOD( "08/12/2011") 
   dVenc += 2
   ? dVenc
   dVenc -= 2
   ? dVenc
   dVenc *= 2  // Operador *= e /= n�o funcionam com datas (ERRO!!)
   ? dVenc  
   

RETURN