/*
Arrays
*/
PROCEDURE Main
LOCAL aQuadrado
LOCAL x

    CLS
    INPUT "Informe a quantidade de elementos : " TO x

    aQuadrado := ARRAY( x ) 

    FOR x := 1 TO LEN( aQuadrado )
        aQuadrado[ x ] := x ^ 2
    NEXT    

    FOR x := 1 TO LEN( aQuadrado )
        ? "Quadrado de ", x , " é " , aQuadrado[ x ]
    NEXT    
            
RETURN


