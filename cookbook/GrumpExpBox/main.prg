/**

Thanks!
-------


To build
--------

hbmk2 main.prg -lgrump

*/

PROCEDURE Main


    IF FILE('title.scr')                      
       PULL_DRAPE('title.scr', 25)            
    ELSE                                      
       |                                      
       cls
       For x := 1 to 100
                ?? x
       Next
       |                                      
       ** create screen file for next time    
       SAVE_DRAPE('title.scr')                
    ENDIF                                     

RETURN
