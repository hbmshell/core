/**
To build
--------

hbmk2 main.prg 

Thanks asimoes !
http://pctoledo.com.br/forum/viewtopic.php?f=4&t=19589&p=127163&hilit=hb_shadow#p127163

*/
PROCEDURE Main
    
   @05,02 TO 10,20
   
   FOR I:=0 TO 255
      IF MOD(I,16) = 0
         HB_SHADOW(05,02,10,20, i)
         @ 06,03 say i
         @ 07,03 say "Type any key"
         Inkey(0)
      ENDIF
   NEXT
   
RETURN


