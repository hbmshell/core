
PROCEDURE HBM_32button

    LOCAL cButton1   
    LOCAL cButton2 
    LOCAL cName := SPACE(20)
    LOCAL GetList := {}
   
    CLS
    @ 05,14 SAY "[Client name]"
    @ 06,14 GET cName 
    @ 08,14 GET cButton1 PUSHBUTTON CAPTION " Cancel " STATE {||  IIF( Alert('Abandon data ?',{"Yes","No"})==1, hb_KeyPut(K_ESC),  ) } COLOR "W/G,N/G,N/G,W/G" 
    @ 10,14 GET cButton2 PUSHBUTTON CAPTION "   Ok   " STATE { || hb_KeyPut(K_CTRL_W) } COLOR "W/G,N/G,N/G,W/G"
    READ

    @ 26,10 SAY IIF( LASTKEY() == K_ESC , "ESC PRESS." , "SAVE DATA / ENTER PRESS." )
    @ 27,10 SAY hb_strformat( "cName : %s", hb_valtoexp(cName) ) COLOR "W/N"
    @ 28,10 SAY hb_strformat( "Button 1 : %s", hb_valtoexp(cButton1) ) COLOR "W/N"
    @ 29,10 SAY hb_strformat( "Button 2 : %s", hb_valtoexp(cButton2) ) COLOR "W/N"

    
    
RETURN


