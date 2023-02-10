// Shebang line
/**


*/
PROCEDURE Main

LOCAL a
LOCAL hHash := { "H" => "First Element" ,; 
                 "a" => 123 ,;
                 "r" => Date() ,;
                 "b" => NIL ,;
                 "o" => Time() ,;
                 "u" => { "Ok" , "All good" } ,;
                 "r " => 0.456 }

    
   FOR EACH a IN hHash
      ? a:__enumKey() , " ==> " , hb_ValToExp( a:__enumValue() )  
   NEXT
   ?

RETURN
