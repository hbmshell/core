/**



*/

PROCEDURE MAIN

    hb_cdpSelect( "EN" )
    ? hb_cdpSelect()
    ? hb_UTF8ToStr( "� < G =" ), hb_BChar( 144 ) < "G" // � < G is .F.
    hb_cdpSelect( "PT850" )
    ? hb_cdpSelect()
    ? hb_UTF8ToStr( "� < G =" ), hb_BChar( 144 ) < "G" // � < G is .T.
    
RETURN

