
#command MOSTRA A TELA INICIAL => MostraTela() 
PROCEDURE Main

    MOSTRA A TELA INICIAL // My Command
       
RETURN 

PROCEDURE MostraTela()

   SET DATE BRITISH

   CLS
   @ 0,0 TO 3,79 DOUBLE
   @ 1,2 SAY "My Information System"
   @ 1,69 SAY DATE()
   @ 2,2 SAY "My Emp"
   
   @ 4,0 TO 21,79 
   @ 22,0 TO 24,79
   ? ""
   
   
RETURN    
   