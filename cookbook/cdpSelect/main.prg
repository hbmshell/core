/**



*/

PROCEDURE MAIN

    hb_cdpSelect( "EN" )
    ? hb_cdpSelect()
    ? hb_UTF8ToStr( "É < G =" ), hb_BChar( 144 ) < "G" // É < G is .F.
    hb_cdpSelect( "PT850" )
    ? hb_cdpSelect()
    ? hb_UTF8ToStr( "É < G =" ), hb_BChar( 144 ) < "G" // É < G is .T.
    
RETURN

