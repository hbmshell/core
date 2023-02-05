PROCEDURE Main
LOCAL cData

   SET DATE BRITISH
   cData := DToC( Date() )

   ? "Today : " + cData

RETURN
