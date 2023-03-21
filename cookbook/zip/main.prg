// Shebang line - Optional
// Compile option (e.g: //-p) - Optional
/**

To build
--------

hbmk2 main hbziparc.hbc

*/
PROCEDURE MAIN

    LOCAL lCompress // Result
    LOCAL cFile := "test.zip" // Result file
    LOCAL cFileToCompress := "test.txt"
    LOCAL nLevel := 1 // 0 - no compression to 9 - best
    LOCAL bBlock // no applicable here (only one file)
    LOCAL lOverWrite := .t. // overwrite if file exists in zip
    LOCAL cPassword := "secret"
    LOCAL lWithPath := .f. // store path or not (.f. is default)
    LOCAL lWithDrive := .f. // store drive letter or not (.f. is default)
    
    IF FILE( cFile )
        ? "Erasing test file : "
        IF FErase(cFile) == 0 
            ?? "Ok"
        ELSE
            ?? "Fails when erasing test.zip"
        ENDIF
    ENDIF
    ? "Begin test"
    ? "Creating test : "
    lCompress := hb_ZipFile( cFile, cFileToCompress , nLevel, bBlock, lOverWrite, cPassword, lWithPath, lWithDrive )
    IF lCompress
        ?? "Success"
    ELSE
        ?? "Fail"
    ENDIF    
    ? "End"

RETURN
