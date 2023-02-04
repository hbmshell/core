

PROCEDURE Main
STATIC a , b
LOCAL c
LOCAL d
LOCAL bAttr := {|| ( b := 12, c := 2 , d := 4 , a := c + d ) }

   ? a , b , c , d
   EVAL( bAttr ) 
   ? a , b , c , d
          
RETURN 

