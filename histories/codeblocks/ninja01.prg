
PROCEDURE MAIN

    LOCAL nNinja := 10
    LOCAL nWeapon := 10

    ? Arena( nNinja )

RETURN

FUNCTION Arena( nNinja )

    LOCAL cResult
    LOCAL nAdversary := 15

    IF nNinja > nAdversary
        cResult := "Ninja wins"
    ELSE
        cResult := "Ninja loses"
    ENDIF    

RETURN cResult