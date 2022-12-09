
PROCEDURE hbMAIN( n )

    LOCAL x
    
    IF n == NIL
        ? "inform samples's number. ex: hbmshell main.prg 10"
        quit
    endif    
    n := VAL( n )
    FOR x := 1 TO n
    
        ? x, Sorteio( n )
        
    NEXT


    RETURN
    
REQUEST HB_CODEPAGE_PTISO    
FUNCTION Sorteio( nMax )

    LOCAL nSorteio
    STATIC aSorteio := {}
    
    nSorteio := HB_RandomInt( 1 , nMax )
    
    DO WHILE .T. 
        IF Ascan( aSorteio , nSorteio ) == 0 // NOT FOUND
            AADD( aSorteio , nSorteio ) // ADD TO DON'T REPEAT
            EXIT
        ENDIF
        
        IF ++nSorteio > nMAX
            nSorteio := 1
        ENDIF   
        IF LEN( aSorteio ) == nMax // FINISH 
            EXIT 
        ENDIF    
    ENDDO    
    
    

RETURN nSorteio    