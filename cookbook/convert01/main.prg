
PROCEDURE Main
LOCAL cNota 
LOCAL nNota 

   cNota := "1200.00"  //  caracter
   nNota := 300 // number

   ? nNota + Val( cNota )
   ? "It worked, but the next one will generate a runtime error..."
   ? nNota + cNota

RETURN