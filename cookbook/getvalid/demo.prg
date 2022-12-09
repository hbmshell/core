
PROCEDURE hb_MAIN

    LOCAL GetList := {}
    
  
    PRIVATE cCodigo := SPACE(5)
    PRIVATE cNome := SPACE(40)
    PRIVATE nSal := 0.00
    
    //SetMode( 50 , 140 )
    CLS
    @ 10,10 SAY "Codigo : " GET cCodigo PICTURE "99999" VALID vValid()
    @ 12,10 SAY "Nome.. : " GET cNome PICTURE "@!" VALID vValid()
    @ 14,10 SAY "Salar. : " GET nSal PICTURE "@RE 999,999.99" VALID vValid()
    READ
    
    IF LASTKEY() <> K_ESC
        ? cCodigo
        ? cNome
        ? nSal
    ELSE
        ALERT("CANCELEI")
    ENDIF
    
    RETURN
    
STATIC FUNCTION vVALID()

    LOCAL cReadVar := READVAR()
    LOCAL xVar 
    LOCAL lRet := .t.
    
    DO CASE
    CASE cReadVar == "CCODIGO"
        
        xVar := &cReadVar
        IF EMPTY( xVar )
            Alert("Informe um valor válido para o código")
            lRet := .f.
        ENDIF
        
    CASE cReadVar == "CNOME"
    
        xVar := &cReadVar
        IF EMPTY( xVar )
            Alert("Informe um valor válido para o nome")
            lRet := .f.
        ENDIF
    
    
    CASE cReadVar == "NSAL"
    
        xVar := &cReadVar
        IF xVar <= 0
            Alert("Informe um valor válido para o salário")
            lRet := .f.
        ELSE
            IF xVar < 1000
                Alert("Esse valor é muito baixo")
                lRet := .f.
            ENDIF
        ENDIF

    ENDCASE
    
    RETURN lRet
