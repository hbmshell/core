
PROCEDURE Main

    LOCAL hHandle
    
    ? "Creating fsociety (Ready Only): " , hHandle := FCreate( "fsociety", FC_READONLY )
    IF hHandle == F_ERROR
        ? "Error"
    ELSE
        ? "Sucess"    
    ENDIF

RETURN    