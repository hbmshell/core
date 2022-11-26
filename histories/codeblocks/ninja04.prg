
PROCEDURE Main()

    LOCAL cBlock := "{|| nNinja + nWeapon }"

    Arena01( cBlock )
    Arena02( cBlock )

RETURN

PROCEDURE Arena01( cBlock )

    LOCAL nNinja := 10
    LOCAL nWeapon := 10

    ? Fight( &cBlock )

RETURN


PROCEDURE Arena02( cBlock )

    LOCAL nNinja := 10
    LOCAL nWeapon := 0

    ? Fight( &cBlock )

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