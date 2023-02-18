
PROCEDURE MAIN


    aFiles := hb_GetFilesInZip( "bit.zip" ) 
    FOR x := 1 TO LEN( aFiles )
        ? aFiles[x]
    NEXT

RETURN
