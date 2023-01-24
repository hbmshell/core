
PROCEDURE Main
LOCAL aNomes1, aNomes2

   aNomes1 := Test( "Gilberto" , "Silvério" )
   aNomes2 := Test( "William" , "Manesco" )
   
   ? "Nome 1 : " , aNomes1[ 1 ] , aNomes1[ 2 ]
   ? "Nome 2 : " , aNomes2[ 1 ] , aNomes2[ 2 ]
   
RETURN 

FUNCTION Test( cFirst, cLast )

RETURN { cFirst , cLast }





