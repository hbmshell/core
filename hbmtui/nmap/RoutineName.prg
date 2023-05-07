PROCEDURE HBM_14range

    
    alert( Hbmrun( "hbmscript getmyip.prg" , "-json" ) )
    alert( hb_ValToExp( ListMyIP() ) )

    Inkey(0)

    
    
RETURN
