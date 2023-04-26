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
 
   INPUT "Type a number to key generation : " TO nVariavel 
   nChaveFinal := EVAL( bChave , nVariavel ) 
   
   ? "The key value : " , nChaveFinal   
          
RETURN NIL

