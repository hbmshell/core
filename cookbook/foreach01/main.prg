// Shebang line
/**

Variable a inside for each loop doesn't get new value

Variable a inside for each loop equal to a:__enumvalue() 
*/
PROCEDURE Main

   ? "Origin value : " , a := "A"
   
   ? "Value inside loop (example 1)" 
   FOR EACH a IN "abcd"
      ? a      // prints: a
               //         b
               //         c
               //         d
   NEXT
   ? "Outside loop: " , a  // prints: A (not d)

   ? "Value inside loop (example 2)"
   FOR EACH a IN "abcd"
      ? a:__enumvalue() // ? a
   NEXT
   ? "Outside loop: " ,a  // prints: A (not d)


RETURN
