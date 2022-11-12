
//-q0
Function Main( ... )

    LOCAL cHello := "", x 

    FOR x := 1 TO 100
        cHello += e"Hello World" + CHR(13)+CHR(10)
    NEXT

        Load Window Main

        Main.Center
        Main.Edit_Pipe.Value := cHello
        Main.Activate

Return
