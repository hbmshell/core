PROCEDURE MAIN

    LOCAL aCsv := hb_ATokens( hb_MemoRead("exemplo.csv"), .t. )
    LOCAL x

    FOR x := 1 TO LEN( aCsv )
        ? aCsv[x]
    NEXT

RETURN
