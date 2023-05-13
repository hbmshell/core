
// hbmk2 main.prg -lgrump 
#include "boxget.ch"
PROCEDURE Main
    
    local nx := 0      
    cls
    boxget nx prompt "Numeric nrest r1 c0" row 1 column 0 norestore

     boxget nx prompt "Enter your number" picture "9999" ;          
              norestore row 4 column 0 title "Pick a number" ;     
              boxcolor '+w/r' color '+w/b,+gr/n'                   
    boxget nx prompt "Enter another number > 20" picture "9999" boxcolor '+w/b' ;
              valid nX > 20 restoreall norestore row 7 column 0    
    


    
RETURN