PROCEDURE Main( ... )

    LOCAL cRet, hRet,x

    for x := 1 to pcount()
        alert( hb_valtoexp(hb_pvalue(x)) )
    next

    alert("Call script getmyip.prg;Type ENTER to continue.")
    cRet := Hbmrun( "hbmdialog scripts" + hb_ps() + "getmyip.prg" , "-json" ) 
    hRet := hb_JsonDecode( cRet )

    alert( hb_ValToExp( hRet ) )

    Inkey(0)

    
    
RETURN
