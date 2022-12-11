#!/usr/local/bin/hbmshell
//https://hmgforum.com/viewtopic.php?f=5&t=7344&sid=e80762c806efc9910511af06c3b9e473
FUNCTION MAIN()
    /******************/
    LOCAL laPrimeCounts := { ;
    {10,1,0.1}, ;
    {100,25,0.2}, ;
    {1000,168,0.3}, ;
    {10000,1229,0.4}, ;
    {100000,9592,0.5}, ;
    {1000000,78498,0.6}, ;
    {10000000,664579,0.7}, ;
    {100000000,5761455,0.8} }
    
       
    
    aSEARCH := {}
    AADD(aSEARCH, 10000)    // FOUND
    AADD(aSEARCH, 664579)   // FOUND
    AADD(aSEARCH, 62364579) // NOT FOUND
    AADD(aSEARCH, .03)      // NOT FOUND
    AADD(aSEARCH, .300)     // FOUND
    
    FOR xx :=  1 to len(aSEARCH)
       nSEARCH := aSEARCH [XX]
       FOR a := 1 to len(laPrimeCounts)
        
          FOR b := 1 to len(laPrimeCounts [a] )
             IF laPrimeCounts [a,b ] == nSEARCH
                ? 'found', laPrimeCounts [a,b ]
             ENDIF
             
          NEXT 
       NEXT
    NEXT

RETURN
    