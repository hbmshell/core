
PROCEDURE MAIN

    LOCAL cExe := "nmap"
    LOCAL cErro
    LOCAL cRet
    
    cRet := VLJ_RUN( cExe , , @cErro )
    
    IF .NOT. EMPTY( cErro )
        alert("O nmap não está visível. Verifique o PATH")
    ELSE
        alert("O nmap está disponível")
    ENDIF


RETURN