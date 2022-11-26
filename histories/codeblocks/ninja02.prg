
PROCEDURE MAIN

    LOCAL nWeapon := 10

    ? Arena01( "{|| Ninja()}" )

RETURN

FUNCTION Ninja()

    LOCAL nNinja := 10

RETURN nNinja + nWeapon

FUNCTION Arena01( cNinja )

    LOCAL cResult
    LOCAL nAdversary := 15
    PRIVATE nWeapon := 0

    IF Eval( &cNinja. ) > nAdversary
        cResult := "Ninja wins"
    ELSE
        cResult := "Ninja loses"
    ENDIF    

RETURN cResult