PROCEDURE Main
LOCAL bBlock := {|| NIL }
         //? Eval( 1 )
         ? Eval( @bBlock )

         //? Eval( {| p1 | p1 }, "A", "B" )
         ? Eval( {| p1, p2 | p1 + p2 }, "A", "B" )
         //? Eval( {| p1, p2, p3 | p1 }, "A", "B" )

   
   
RETURN 


