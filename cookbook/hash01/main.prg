// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
FUNCTION Main
local harr := { => }

    harr["six"] := 6
    harr["eight"] := 8
    harr["eleven"]:=11
    
    harr[10] := "str1"
    harr[23] := "str2"
    harr["fantasy"] := "fiction"
    
    ? harr[10], harr[23]                                   // str1  str2
    ? harr["eight"], harr["eleven"], harr["fantasy"]       // 8       11  fiction
    ? len(harr)                                            // 6
    ?
    
    RETURN nil
