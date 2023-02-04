
PROCEDURE Main
LOCAL a
LOCAL b1 := {||a[1]} // a[1] doesn't exists 

   ? "a[1] doesn't exists, but was 'used' in b1 definition"
   a := { "a[1] exists now" }
   ? EVAL( b1 ) // Ok
          
RETURN 

