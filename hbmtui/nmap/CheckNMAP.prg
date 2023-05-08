
PROCEDURE MAIN

    LOCAL cExe := "nmap"
    LOCAL cErro
    LOCAL cRet
    
    cRet := VLJ_RUN( cExe , , @cErro )
    
    IF .NOT. EMPTY( cErro )
        alert("nmap is not visible. check the PATH")
    ELSE
        alert("nmap is available.")
    ENDIF


RETURN