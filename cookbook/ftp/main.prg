 PROCEDURE MAIN

    oURL := TUrl():new()
    oUrl:cProto    := "ftp"
    oUrl:cUserid   := "dlpuser"  // change it
    oUrl:cPassword := "rNrKYTX9g7z3RgJRmxWuGHbeu"         // change it
    oUrl:cServer   := "ftp.dlptest.com"             // change it
    oUrl:nPort     := 21            
    
    
    oFTP := TIpClientFtp():new( oURL ) // open ftp connect     
     
    IF oFTP:OPEN()      
        ? "Connection made successfully"
        oFTP:CWD("/")    // altere
     
        aNUVEM := oFTP:listFiles()  
        ? "Listing files"
        FOR x := 1 TO LEN( aNuvem )
            ? aNuvem[x][1]
        NEXT    
        ? Replicate("-",80)
        ? "Downloading " , aNuvem[1][1]
        IF oFTP:downloadFile( aNuvem[1][1] ) // 
           ? "oK"
           FErase( aNuvem[1][1] )
        ELSE
        
           ? "File " , cFile, "not found"
           ? oFtp:lastErrorMessage()
            
        ENDIF
    ELSE
        ? "Connection not openned"
        ? oFtp:lastErrorMessage()
    ENDIF
     