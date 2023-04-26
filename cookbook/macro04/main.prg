
FUNCTION Main
LOCAL cExpressao, bBloco

   ACCEPT "Expression (E.g: Date()+2) : " TO cExpressao
  
   BEGIN SEQUENCE WITH __BreakBlock()
      bBloco := &( "{|| " + cExpressao + " }" )
      ? EVAL( bBloco )
   RECOVER
      ? "This expression have a error"
   END SEQUENCE   
          
RETURN NIL
