FUNCTION Main
LOCAL cExpressao, bBloco

   ACCEPT "Type expression (e.g.: 2+2): " TO cExpressao
   
   BEGIN SEQUENCE WITH __BreakBlock()
      bBloco := &( "{|| " + cExpressao + " }" )
      ? EVAL( bBloco )
   RECOVER
      ? "Error in expression informed"
   END SEQUENCE 

          
RETURN NIL

