
PROCEDURE Main
LOCAL nTotal 

   nTotal := 1300.456

   ? "Total : " + Str( nTotal )
   ? "Total : " + Str( nTotal , 10 )
   ? "Total : " + Str( nTotal , 5 , 2)
   ? "Total : " + Str( nTotal , 3 , 2)
   ? "Total : " + HB_ValToStr( nTotal )
   ? "It worked, but the next one will generate a runtime error..."
   ? "Total : " + nTotal

RETURN

