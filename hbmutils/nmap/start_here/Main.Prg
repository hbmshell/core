#include <hmg.ch>
#include <hbmediator.ch>

Function Main

        Load Window Main
        Main.Center
        AddItemInCombo()
        Main.Activate

Return

Static Procedure AddItemInCombo()

    LOCAL aParams := {}
    LOCAL cScript
    LOCAL hIpList, cResult, cElem
    
    AADD( aParams , "..\core\getmyip.prg" )
    AADD( aParams , "--virtual-include" )
    AADD( aParams , "-json" )
    cScript := "hbmdialog"

    EXEC RUN cScript PARAMETERS hb_ArrayToParams( aParams ) TO cResult
    
    hIpList := hb_JsonDecode( cResult )
    IF hIpList["Result"]=="OK"
    
        FOR EACH cElem IN hIpList["Content"]
            Main.Combo_Net.AddItem( cElem )
        NEXT
    
    ELSE
    
        MsgInfo( "Error when execute " + cScript )
    
    ENDIF

Return

Static Procedure ScanNow()


    LOCAL aParams := {}
    LOCAL cScript
    LOCAL hIpList, cResult, cElem
    
    AADD( aParams , "..\core\nmap_scanner_ip.prg" )
    AADD( aParams , "--virtual-include" )
    AADD( aParams , "-network" )
    AADD( aParams , "127.0.0.0/24" )
    cScript := "hbmdialog"

    EXEC RUN cScript PARAMETERS hb_ArrayToParams( aParams ) TO cResult
    
    hIpList := hb_JsonDecode( cResult )
    IF hIpList["Result"]=="OK"
    
        MsgInfo( hIpList["Content"] )
        
    ELSE
    
        MsgInfo( "Error when execute " + cScript )
    
    ENDIF


Return
