// Shebang line
/**


*/
PROCEDURE Main

LOCAL a,b

   arr := { 1, 2, 3 }
   str := "abc"
   FOR EACH a, b IN arr, str
      ? a *= 2, b := Upper( 'Whatever' )
   NEXT
   ? "now `arr` stores { 2, 4, 6 }     :" , hb_ValToExp(arr)
   ? 'however `str` still stores "abc" :',  str

RETURN
