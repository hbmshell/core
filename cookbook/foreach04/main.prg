// Shebang line
/**


*/
PROCEDURE Main

   a := "A"
   // you can use EXIT statement inside the loop
   FOR EACH a IN { 1, 2, 3, 4 }
      IF a:__enumIndex() == 3
         ? a
         EXIT
      ENDIF
   NEXT

RETURN
