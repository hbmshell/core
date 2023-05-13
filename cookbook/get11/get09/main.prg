
PROCEDURE HBM_21picture

    LOCAL cObs := SPACE(512)
    LOCAL nDebt := -1200
    LOCAL cName := SPACE(20)
    LOCAL cComment := "NO COMMENT                                              "
    LOCAL nRow := 34, nCol := 10, nWidth := 110


    CLS
    @ 08,10 SAY "Obs                       : " GET cObs PICTURE "@S30" MESSAGE "@S :  Scrolling horizontally after overflow"
    @ 10,10 SAY "Debt                      : " GET nDebt PICTURE "@(" MESSAGE "@( : show negative numbers between parentheses, with spaces in left"
    @ 12,10 SAY "Debt                      : " GET nDebt PICTURE "@)" MESSAGE "@) : show negative numbers between parentheses, WITHOUT spaces in left"    
    @ 14,10 SAY "Name                      : " GET cName  PICTURE "@!" MESSAGE "@! : Force upper case"
    @ 16,10 SAY "Comment                   : " GET cComment  PICTURE "@K" MESSAGE "@K : Erase default text after type alphanumeric key"
    
    READ MSG AT nRow, nCol, nWidth MSG COLOR "N/W" // <------------------------------------------ MESSAGE Coordinate and width 
    SET DATE TO BRITISH

    WAIT
    
RETURN



