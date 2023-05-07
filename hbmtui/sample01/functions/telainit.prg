#include "box.ch"
PROCEDURE TelaInit( cEmp )

    LOCAL nMaxCol := MaxCol()-1
    LOCAL nMaxRow := MaxRow()-1
    LOCAL cTitle := VLJ_ConfigJson2Value( "config.json" , "title" , ""  ) 

    hb_default( @cTitle,"")
    hb_default( @cEmp,"")
    CLS
    @ 0,0 TO 3,nMaxCol DOUBLE
    @ 1,2 SAY cTitle
    @ 1,nMaxCol-Len(Dtoc(Date())) SAY DATE()
    @ 2,2 SAY cEmp
    @ 4,0 TO nMaxRow-3,nMaxCol 

    @ nMaxRow-2,0 TO nMaxRow,nMaxCol
    

RETURN