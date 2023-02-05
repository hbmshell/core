PROCEDURE HBM_31listbox

    LOCAL aList := { "Option1" , "Option2" , "Option3" } 
    LOCAL aCity := { "Milano", "Genova", "Roma", "Pisa", "Torino" }
    LOCAL nSelect := 0
    LOCAL cSelect := ""
    LOCAL nSelect2 := 0
    LOCAL cSelect2 := "" 
    
    CLS
#ifdef __PLATFORM__WINDOWS
    SetMode(100,150)
#endif

    @ 08,14,13,30 GET nSelect LISTBOX aList CAPTION "My Dropdown" DROPDOWN SCROLLBAR COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*,N/G" // Must be 8 Colors
    @ 08,54,13,70 GET cSelect LISTBOX aList CAPTION "My Dropdown 2" DROPDOWN SCROLLBAR COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*,N/G" // Must be 8 Colors
    @ 15,14,25,30 GET nSelect2 LISTBOX aCity CAPTION "My Listbox" COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*" // Must be 7 Colors
    @ 15,54,25,70 GET cSelect2 LISTBOX aCity CAPTION "My Listbox 2" COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*" // Must be 7 Colors
    READ

    @ 28,10 SAY hb_strformat( "My Dropdown return : %d and My Dropdown 2 return %s", nSelect, cSelect ) COLOR "W/N"
    @ 29,10 SAY hb_strformat( "My ListBox return : %d and My ListBox 2 return %s", nSelect2, cSelect2 ) COLOR "W/N"

    WAIT 
    
RETURN