
PROCEDURE Main

    LOCAL hHandle
    
    ? "Creating fsociety (Hidden): " , hHandle := FCreate( "fsociety", FC_HIDDEN )
    IF hHandle == F_ERROR
        ? "Error"
    ELSE
        ? "Sucess"  
        IF .NOT. FILE( "fsociety" )
            ? "The FILE() function doesn't see hidden files"
        ENDIF  
    ENDIF

RETURN    