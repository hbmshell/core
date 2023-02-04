#define CONST_UNIVERSAL 8600

FUNCTION Main
LOCAL bChave, nVariavel
LOCAL nChaveFinal

   bChave := {| nVar |
                LOCAL nToken := SECONDS()
                LOCAL nResult
                
                   nResult := nVar * nToken + CONST_UNIVERSAL
                
                  
                RETURN nResult
             }
 
   INPUT "Informe a number: " TO nVariavel 
   nChaveFinal := EVAL( bChave , nVariavel ) 
   
   ? "The key value is " , nChaveFinal   
          
RETURN NIL

