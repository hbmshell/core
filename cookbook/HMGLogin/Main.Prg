
Function Main

        Load Window Main
        Main.Center
        Main.Activate

Return

Function Login()

    Local cUsername := getProperty("Main","Text_Username","Value")
    Local cPassword := getProperty("Main","Text_Password","Value")
    
    if empty( cUsername )
        msgstop( "Inform user name" )
        doMethod("Main","Text_Username","SetFocus")
        return nil
    endif
    
    if empty( cPassword )
        msgstop( "Inform password" )
        doMethod("Main","Text_Password","SetFocus")
        return nil
    endif
        
    

RETURN NIL


