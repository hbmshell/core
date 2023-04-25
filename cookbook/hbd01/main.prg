/**

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL aEntryList := {}
    AADD( aEntryList , 123 )
    AADD( aEntryList , "Harbour Power" )
    AADD( aEntryList , { "01" => "First Hash Element" , "02" => "Second Hash Element" } )
    
    __hbdoc_SaveHBD ( "harbour", aEntryList )

RETURN
