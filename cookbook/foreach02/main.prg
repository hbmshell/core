// Shebang line
/**

Variable a inside for each loop doesn't get new value

Variable a inside for each loop equal to a:__enumvalue() 
*/
PROCEDURE Main

   LOCAL cString := "abcd"
   
   

   ? "Example 1"
   ? "Origin value : " , a := "A"
   ? "Origin string : ", cString
   
   ? "inside loop"
   FOR EACH a IN cString
      ? a := Upper(a) 
   NEXT
   ? "Value was not changed outside loop: " ,a  
   ? "String was not changed: ", cString
   
   ? "-----------------------------------------------------"

   ? "Example 2"
   ? "Origin value : " , a := "A"
   ? "Origin string : ", cString
   
   ? "inside loop (cString passed by reference)"
   FOR EACH a IN @cString // by reference
      ? a := Upper(a) 
   NEXT
   ? "Value was not changed outside loop: " ,a  
   ? "String was changed: ", cString
   ?



RETURN
