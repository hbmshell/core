
PROCEDURE Main()

    Arena01()
    Arena02()

RETURN

PROCEDURE Arena01()

    LOCAL nNinja := 10
    LOCAL nWeapon := 10

    ? Fight( {|| nNinja + nWeapon } )

RETURN


PROCEDURE Arena02()

    LOCAL nNinja := 10
    LOCAL nWeapon := 0

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