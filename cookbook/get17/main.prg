
PROCEDURE HBM_37intensity

    LOCAL cField := "JOSEPH READ WRITE   "
    LOCAL cField2 := "MARKETING   "
    LOCAL cField3 := SPACE(30)

    CLS
    SET INTENSITY OFF
    @ 10, 10 SAY "Name       : " GET cField 
    @ 12, 10 SAY "Cargo      : " GET cField3
    SET INTENSITY ON
    @ 14, 10 SAY "Department : " GET cField2
    READ
   
    WAIT 
    
RETURN
