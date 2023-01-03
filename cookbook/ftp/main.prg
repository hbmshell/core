 PROCEDURE MAIN

    oURL := TUrl():new()
    oUrl:cProto    := "ftp"
    oUrl:cUserid   := "dlpuser"  // altere
    oUrl:cPassword := "rNrKYTX9g7z3RgJRmxWuGHbeu"         // altere
    oUrl:cServer   := "ftp.dlptest.com"             // altere
    oUrl:nPort     := 21            
     
    
    oFTP := TIpClientFtp():new( oURL ) // ABRE CONEXÃO FTP      
     
    IF oFTP:OPEN()      
      
        oFTP:CWD("/")    // altere
     
        aNUVEM := oFTP:listFiles()      
        IF oFTP:downloadFile( "03012023.csv" ) // 
           ? "oK"
        ELSE
           ? oFtp:lastErrorMessage()
            
        ENDIF
    ELSE
        ? oFtp:lastErrorMessage()
    ENDIF
     