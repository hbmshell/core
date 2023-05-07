#include "inkey.ch"
PROCEDURE MAIN( cIp , cNhac )

    LOCAL GetList := {}
    LOCAL cAddress := Space(30)
    
    IF Empty( cIp )
        TelaInit("Escaneamento Simples")

        @ 15,5 say "Informe o endereço da rede" get cAddress
        READ

        IF Lastkey()==K_ESC
        ELSE
            Alert( ExecNMap( cAddress ) )
        ENDIF
    ELSE
        ? ExecNmap( cIp )
    ENDIF

RETURN

STATIC FUNCTION ExecNmap( cIp )
    
    LOCAL cErro, cRet
    
    cRet := VLJ_RUN( "nmap -v" , {cIp} , @cErro )
    IF .NOT. EMPTY( cErro )
        cRet := cErro
    ENDIF
    
RETURN cRet