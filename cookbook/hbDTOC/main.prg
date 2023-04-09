/**

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    ? hb_DtoC( Date() , "YYYY-MM-DD" )
    ? hb_DtoC( Date() , "YY-MM-DD" )
    ? hb_DtoC( Date() , "MM/DD/YYYY" )

RETURN
