/*
Arrays
*/
PROCEDURE Main
LOCAL aQuadrado := {}
LOCAL x
LOCAL nValor


    DO WHILE .T.
       INPUT "Type a number (999 Exit) " TO nValor
       IF nValor == 999
          EXIT
       ENDIF   
       AADD( aQuadrado, nValor )
    ENDDO   
    
    FOR x := 1 TO LEN( aQuadrado )
        ? aQuadrado[x] , "^" + hb_ntos(x) , ( aQuadrado[x] ^ 2 )
    NEXT    
            
RETURN


