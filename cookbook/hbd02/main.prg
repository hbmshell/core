/**

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL hDoc

    FOR EACH hDoc IN __hbdoc_LoadHBD( "harbour.hbd" )
        ? hb_ValToExp( hDoc )
        
    NEXT

RETURN
