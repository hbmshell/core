
FUNCTION Main
LOCAL cExpressao, bBloco

   ACCEPT "Expression (E.g: Date()+2) : " TO cExpressao
   bBloco := &( "{|| " + cExpressao + " }" )
   ? EVAL( bBloco )

          
RETURN NIL
