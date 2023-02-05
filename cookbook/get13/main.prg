PROCEDURE HBM_33radio

    LOCAL cRadio1 := Space(10)
    LOCAL nRadio2 := 0
    LOCAL aList := {}
    LOCAL aList2 := {}

    AADD( aList , RadioButto( 9 , 15 , "Opt 1" ) )
    AADD( aList , RadioButto( 10 , 15 , "Opt 2" ) )
    AADD( aList , RadioButto( 11, 15 , "Opt 3" ) )
    AADD( aList , RadioButto( 12 , 15 , "Opt 4" ) )

    AADD( aList2 , RadioButto( 9 , 45 , "Opt 1" ) )
    AADD( aList2 , RadioButto( 10 , 45 , "Opt 2" ) )
    AADD( aList2 , RadioButto( 11, 45 , "Opt 3" ) )
    AADD( aList2 , RadioButto( 12 , 45 , "Opt 4" ) )

    CLS
    @ 08,14,13,30 GET cRadio1 RADIOGROUP aList CAPTION "My Radio 1" 
    @ 08,44,13,60 GET nRadio2 RADIOGROUP aList2 CAPTION "My Radio 2"     
    READ

    @ 28,10 SAY hb_strformat( "Radio 1 : %s", hb_valtoexp(cRadio1) ) COLOR "W/N"
    @ 29,10 SAY hb_strformat( "Radio 2 : %d", nRadio2 ) COLOR "W/N"

    WAIT 
    
RETURN


