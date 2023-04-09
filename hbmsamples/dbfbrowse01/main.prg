
#include <hbmediator.ch>

PROCEDURE MAIN

    LOCAL lResult
    LOCAL aStruct := {}
    
    AADD( aStruct , { "id" , "N" , 10 , 0 } )
    AADD( aStruct , { "name" , "C" , 30 , 0 } )
    AADD( aStruct , { "dtbirth" , "D" , 8 , 0 } )
    
    USE Teste STRUCT aStruct TO lResult // Pseudo-command defined in vdata.ch (hbmediator.ch)
    IF lResult 
        ? "Ok"
        Browse()
    ENDIF


RETURN