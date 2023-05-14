//
// hbmk2 main.prg -lgrump 

#define FRAMEBOX 1 // 1,2,3,4,5
PROCEDURE Main

    LOCAL mDATE := CTOD("")   && beats using ("  /  /  ")

    
    
    

    SHADOWBOX(11, 21, 13, 58, FRAMEBOX, 'Date Entry' )
    
    @ 12, 23 SAY 'Enter the starting date:'
    @ 12, 48 GET mDATE PICTURE '@D'
    READ
    //ByeByeBox(buffer)


    
RETURN