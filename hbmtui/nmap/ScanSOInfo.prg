#include "inkey.ch"
PROCEDURE MAIN( cIp  )

    LOCAL GetList := {}
    LOCAL cAddress := Space(30)
    
    IF Empty( cIp )
        TelaInit("Get OS Information")

        @ 15,5 say "Inform IP address" get cAddress
        READ

        IF Lastkey()==K_ESC
        ELSE
            Alert( ExecNMap( cAddress ) )
        ENDIF
    ELSE
        ? ExecNmap( cIp )
    ENDIF

RETURN

STATIC FUNCTION ExecNMap( cIp )
    
    LOCAL cErro, cRet
    
    cRet := VLJ_RUN( "nmap -O" , {cIp} , @cErro )
    IF .NOT. EMPTY( cErro )
        cRet := cErro
    ENDIF
    
RETURN cRet