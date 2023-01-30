
PROCEDURE MAIN

    LOCAL xVar:=10
    LOCAL pFunc := @Func_ALgo()
    
    ? "Result : " , ( pfunc:exec( xVar ) )


    RETURN

FUNCTION FUNC_ALGO( xVar )


    RETURN xVar*2