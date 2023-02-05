
PROCEDURE HBM_18when

    LOCAL cSex := " "
    LOCAL cName := SPACE(30)
    LOCAL cPap := cSp := cBlood := " "

    CLS
    
    @ 08,10 SAY "Name                      : " GET cName VALID CheckField( cName )
    @ 10,10 SAY "(M)ale or (F)emale        : " GET cSex VALID CheckField( cSex ) .and. cSex $ ("MF")  
    @ 12,10 SAY "Pap smear OK ? (Y/N)      : " GET cPap VALID CheckField( cPap ) .and. cPap $ ("YN") WHEN cSex == "F" // Papanicolau
    @ 14,10 SAY "Spermogram OK ? (Y/N)     : " GET cSp VALID  CheckField( cSp ) .and. cSp $ ("YN") WHEN cSex == "M" 
    @ 16,10 SAY "Blood test OK ? (Y/N)     : " GET cBlood VALID CheckField( cBlood ) .AND. cBlood $ ("YN") 

    READ  

    WAIT
    
RETURN

STATIC FUNCTION CheckField( xVal )

    LOCAL lRet := .t.
    IF EMPTY( xVal )
        Alert("Field is mandatory")
        lRet := .f.
    ENDIF    

RETURN lRet

