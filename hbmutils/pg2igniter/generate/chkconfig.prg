#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "dbstruct.ch"
PROCEDURE Hbm_ChkConfig( ... )
    
    LOCAL cFile := "config.json"

    IF FILE( cFile )
        IF EMPTY( hb_jsonDecode( hb_MemoRead( cFile ) ) )
            ? "Arquivo config.json inválido"
            ERRORLEVEL(113) 
        ELSE
            hJson := hb_jsonDecode( hb_MemoRead( cFile ) ) 
            IF hb_HHasKey( hJson, "chkjson")
                ? "Config.json OK"
            ELSE
                ? "Chave chkjson não encontrado" 
                ERRORLEVEL(115)   
            ENDIF
        ENDIF 
    ELSE
        ? "Arquivo config.json inexistente"
        ERRORLEVEL(114) 
    ENDIF        

