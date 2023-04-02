
#include "box.ch"
PROCEDURE Main
LOCAL nLinTop, nColEsq, nLinBase, nColDir // Coordenadas
   
   nColEsq := 1
   nColDir := 20
   nLinTop := 1
   nLinBase := nLinTop + 5

  
     
   @ nLinTop, nColEsq, nLinBase, nColDir BOX B_SINGLE

   nLinTop := nLinTop + 7
   nLinBase := nLinTop + 5
   @ nLinTop, nColEsq, nLinBase, nColDir BOX B_DOUBLE
   
   nLinTop := nLinTop + 7
   nLinBase := nLinTop + 5
   @ nLinTop, nColEsq, nLinBase, nColDir BOX B_SINGLE_DOUBLE

   nLinTop := nLinTop + 7
   nLinBase := nLinTop + 5
   @ nLinTop, nColEsq, nLinBase, nColDir BOX B_DOUBLE_SINGLE

RETURN
