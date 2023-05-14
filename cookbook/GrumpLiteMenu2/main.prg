
// hbmk2 main.prg -lgrump 
#include "grumpm.ch" 
procedure main

                                         
local menulist := {}, sel, sec_level := 0, x                  
@ 10, 20 PROMPT 'Data entry' MESSAGE 'Enter data' ;           
                             MESSAGECOLOR '+W/B' ACTION alert('dataent()')
@ 11, 20 PROMPT 'Reports' MESSAGE 'Output data' ACTION alert('reps()') TO x
@ 12, 20 PROMPT 'Invoices'   MESSAGE 'Get money!' ;           
                             MESSAGECOLOR '+W/R' ACTION alert('inv()') 
// note: trigger letter for next option will be "F"           
@ 13, 20 PROMPT 'Reindex ~Files' ACTION alert('maint()')               
// note: trigger letter for next option will be "S" and       
// will only be selectable by users with a security level above 0 
@ 14, 20 PROMPT 'Dumb ~Stuff' WHEN sec_level > 0 ACTION alert('dumbstuf()')
@ 15, 20 PROMPT 'Quit'                                        
// highlight 2nd option, display clock, save screen after 5 mins. 
MENU TO sel CLOCK INITIAL 2 TIMEOUT 300 TRIGGERCOLOR "n/bg"   

? sel

   
return