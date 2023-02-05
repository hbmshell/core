PROCEDURE MAIN

    LOCAL aCsv := hb_ATokens( hb_MemoRead("exemplo.csv"), .t. )
    LOCAL aLinha 
    LOCAL x,y

    FOR x := 2 TO LEN( aCsv )
        aLinha := hb_ATokens( aCsv[x] , "," )
        ?
        FOR y := 1 TO LEN( aLinha )
            ?? aLinha[y] , "  "
        NEXT    
    NEXT

RETURN