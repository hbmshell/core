/*
CORES
*/
PROCEDURE Main
LOCAL cImprime := "HARBOUR PROJECT"
LOCAL cCaracter

   SET COLOR TO "G/N"
   ?
   ? "   Lembra a cor usada pelos antigos monitores - Old School Color"    
   ?
   FOR EACH cCaracter IN cImprime
      ? "    ", cCaracter
   NEXT  
   ?
   
RETURN