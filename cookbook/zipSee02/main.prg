//https://www.kresin.ru/en/hrbfaq_4.html

PROCEDURE MAIN

    LOCAL lVerbose := .t. // 

    aFiles := hb_GetFilesInZip( "bit.zip" , lVerbose) 
    FOR x := 1 TO LEN( aFiles )
    /*
    // a two dimensional array with the following info for every file: 
    { cFileName, nSize, nMethod, nCompSize, nRatio, 
    dDate, cTime, hb_NumToHex( nCRC, 8 ), nInternalAttr, lCrypted, cComment }
    */
        ? hb_ValToExp( aFiles[x] )
    NEXT

RETURN
