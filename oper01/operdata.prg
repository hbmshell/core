/*
Variável Data e operadores += e -=
*/
PROCEDURE Main
LOCAL dVenc // Data de vencimento
   SET DATE BRITISH
   dVenc := CTOD( "08/12/2011") 
   dVenc += 2
   ? dVenc
   dVenc -= 2
   ? dVenc
   dVenc *= 2  // Operador *= e /= não funcionam com datas (ERRO!!)
   ? dVenc  
   

RETURN