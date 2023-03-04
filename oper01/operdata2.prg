/*
Variável Data e operadores -=
*/
PROCEDURE Main
LOCAL dVenc // Data de vencimento
LOCAL dPag // Data de pagamento

   SET DATE BRITISH
   dVenc := CTOD( "08/12/2011") 
   dPag := CTOD( "02/12/2011")
   dVenc -= dPag
   ? "A diferença entre o vencimento e o pagamento foi de ", dVenc, "dias"

RETURN