#!/workspace/hbmshell/hbmshell --dialog tui
//-q0

PROCEDURE HBM_11intro

    LOCAL cName := SPACE(30)  // (1) Declare variable first (It's mandatory)

    CLS
    @ 10,10 SAY "Client name : " GET cName // (2) Coordinates
    READ // <---- (3) Reading values typed  

    @ 12,10 SAY "Name : " + cName // (4) Values typed now are stored in variable. If user type ESC then values not storage in variable.


    
    
RETURN
