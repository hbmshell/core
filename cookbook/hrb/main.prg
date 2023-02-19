

PROCEDURE Main

    LOCAL handle := hb_hrbLoad( "hrbtest.hrb" )
    
    &( "HelloHrb( 'Vlad' )" )
    
    hb_hrbUnload( handle )

RETURN
