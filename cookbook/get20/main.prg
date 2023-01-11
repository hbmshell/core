PROCEDURE HBM_41listbox

    LOCAL aList := { "Option1" , "Option2" , "Option3" } 
    LOCAL hGet := {=>}
    LOCAL cDummy := "     "
    
    hGet["N1"] := "          "
    HGet["N2"] := 0

    CLS
    @ 08,14,13,30 GET hGet["N1"] LISTBOX aList CAPTION "My Dropdown" VALID ( alert(HB_VALTOEXP(hGet)) , .T. ) DROPDOWN SCROLLBAR COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*,N/G" // Must be 8 Colors
    @ 08,54,13,70 GET hGet["N2"] LISTBOX aList CAPTION "My Dropdown 2" VALID ( alert(Hb_VALTOEXP( hGet )) , .t. ) DROPDOWN SCROLLBAR COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*,N/G" // Must be 8 Colors
    @ 10,14 GET cDummy 
    READ

    @ 28,10 SAY hb_valtoexp( hGet ) 
    WAIT 
    
RETURN