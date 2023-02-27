PROCEDURE Main
LOCAL nSal := 57500.57
LOCAL cName := "Jonh"

   ? "hb_StrFormat is like a C printf function"
   ? "----------------------------------------"
   ? hb_StrFormat( "Your is %s" , cName )       , "<---- %s is string"
   ? hb_StrFormat( "Your salary is %d" , nSal ) , "<---- %d is decimal (only integer. Rounded value if float)"
   ? hb_StrFormat( "Your salary is %f" , nSal ) , "<---- %f is float"
   ? hb_StrFormat( "Your salary in hexadecimal is %x", nSal) , "<--- %x is hexadecimal value"


RETURN
