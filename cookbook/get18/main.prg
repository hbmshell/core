PROCEDURE HBM_38cursor

    LOCAL cField := "JOSEPH READ WRITE   "
    LOCAL cField2 := "MARKETING   "
    LOCAL cField3 := SPACE(30)
    LOCAL nCursor := 1
    LOCAL aList := { "NONE" , "TYPE 1" , "TYPE 2" , "TYPE 3", "TYPE 4" } 

    CLS
    @ 06,10,11,30 GET nCursor LISTBOX aList CAPTION "Select Cursor Type" DROPDOWN SCROLLBAR COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*,N/G" // Must be 8 Colors
    READ

    SetCursor( nCursor - 1  )
    @ 08,10 SAY "CURSOR TYPE : " + hb_ntos( SetCursor() )
    @ 10, 10 SAY "Name       : " GET cField 
    @ 12, 10 SAY "Cargo      : " GET cField3
    @ 14, 10 SAY "Department : " GET cField2
    READ
   
    WAIT
    
RETURN
