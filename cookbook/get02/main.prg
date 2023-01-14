#!/workspace/hbmshell/hbmshell 

PROCEDURE HBM_13intro

    LOCAL cName := SPACE(30)  
    LOCAL dBirth := CTOD("1970-01-01")
    LOCAL nRow := 14, nCol := 10, nWidth := 30

    CLS

    @ 10,10 SAY "Client name  : " GET cName MESSAGE "Type client name" // <------- MESSAGE Clause
    @ 12,10 SAY "Birth's date : " GET dBirth MESSAGE "Type client birth" // <----- MESSAGE Clause
    READ MSG AT nRow, nCol, nWidth MSG COLOR "N/W" // <------------------------------------------ MESSAGE Coordinate and width

    @ 16,10 SAY "Name : " + cName 
    @ 18,10 SAY "Your age : " + Str( Int( (Date()-dBirth)/365) )


    WAIT "Type any key"
    
RETURN
