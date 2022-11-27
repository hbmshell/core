
PROCEDURE Main()

    Arena( 0 )
    Arena( 100 )

RETURN

PROCEDURE Arena( nWeapon )

    LOCAL nNinja := 10
 
    ? Fight( {|| nNinja + nWeapon } )

RETURN


/*
*/
FUNCTION Fight( bNinja )

    LOCAL cResult
    LOCAL nAdversary := 15

    IF EVAL(bNinja) > nAdversary
        cResult := "Ninja wins"
    ELSE
        cResult := "Ninja loses"
    ENDIF    

RETURN cResult