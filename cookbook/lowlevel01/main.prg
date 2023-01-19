
PROCEDURE Main

    LOCAL hHandle
    
    ? "Creating fsociety : " , hHandle := FCreate( "fsociety" )
    IF hHandle == F_ERROR
        ? "Error"
    ELSE
        ? "Sucess"    
    ENDIF

RETURN    