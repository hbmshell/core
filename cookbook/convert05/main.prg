PROCEDURE Main
LOCAL dData := Date()
LOCAL nSal := 57500
LOCAL cName := "Jonh"
LOCAL lStatus := .t.

   ? "Coverting to string : " 
   ? hb_ValToStr( dData ) + " / " + hb_ValToStr( nSal ) + " / " + hb_ValToStr( cName ) + " / " +  hb_ValToStr( lStatus )

RETURN
