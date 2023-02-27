// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
FUNCTION Main
    local harr := hb_Hash( "six", 6, "eight", 8, "eleven", 11 )
     
       harr[10] := "str1"
       harr[23] := "str2"
       harr["fantasy"] := "fiction"
     
       ? harr[10], harr[23]                                   // str1  str2
       ? harr["eight"], harr["eleven"], harr["fantasy"]       // 8       11  fiction
       ? len(harr)                                            // 6
       ?
     
       RETURN nil
