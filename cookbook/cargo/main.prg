
REQUEST HB_CODEPAGE_PTISO
#include "inkey.ch"

PROCEDURE MAIN

    LOCAL GetList := {}
    LOCAL cNome := SPACE(40)
    LOCAL cCodigo := SPACE(3)
    LOCAL cObs := SPACE(40)
    
    hb_CdpSelect( "PTISO" )
    
    CLS
    #ifdef __PLATFORM__WINDOWS
        ? "Setmode : " , SetMode(50,150)
    #endif
  
        
    @ 05,03 SAY "Nome       : " GET cNome
    @ 07,03 SAY "Código     : " GET cCodigo MESSAGE "Type F3 to search"
    @ 09,03 SAY "Observação : " GET cObs
    
    GetList[2]:cargo := "aditional parameters" // <<<-------- 
    
    SET KEY K_F3 TO JanelaBusca()
    READ MSG AT 20,00,79 MSG COLOR "W+/BG"
    SET KEY K_F3 TO


RETURN

    
FUNCTION JanelaBusca()
    
    IF READVAR() == "CCODIGO"
        alert( hb_valtoexp( GetActive():cargo() ) )
        ALERT("ATIVANDO BUSCA")
    ENDIF    

    RETURN .t.