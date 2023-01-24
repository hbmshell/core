/*
Arrays
*/
PROCEDURE Main
LOCAL aQuadrado := {}
LOCAL x
LOCAL nValor


    DO WHILE .T.
       INPUT "Informe o elemento (999 FINALIZA) " TO nValor
       IF nValor == 999
          EXIT
       ENDIF   
       AADD( aQuadrado, nValor )
    ENDDO   
    
    FOR x := 1 TO LEN( aQuadrado )
        ? "O quadrado de " , aQuadrado[x] , " é " , ( aQuadrado[x] ^ 2 )
    NEXT    
            
RETURN


