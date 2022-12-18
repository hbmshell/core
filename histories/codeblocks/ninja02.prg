PROCEDURE MAIN

    LOCAL nNinja := 10
    LOCAL nWeapon := 10

    ? Arena( {||nNinja} )

RETURN

FUNCTION Arena( bNinja )

    LOCAL cResult
    LOCAL nAdversary := 15

    IF EVAL(bNinja) > nAdversary
        cResult := "Ninja wins"
    ELSE
        cResult := "Ninja loses"
    ENDIF    

RETURN cResult