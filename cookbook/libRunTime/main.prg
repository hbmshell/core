/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
#include "directry.ch"
MEMVAR P_Hrb

procedure main

    local pFunc,x
    PUBLIC P_Hrb := { => } // must be PUBLIC

    loadfunctions()
    ? "Execute"
     
    Do("f1")
    Do("f2")
    Do("f3")
    

return

procedure LoadFunctions()

    LOCAL pPointer
    LOCAL cCode
    LOCAL aDir AS ARRAY
    LOCAL x
    LOCAL oErr
    //LOCAL P_Hrb := { => } // Error. P_Hrb must be a public variable
    

    ? "****************************************************************************"
    ? "Start compile files in preload folder"
    ? "****************************************************************************"
    aDir := Directory( "preload" + hb_ps() + "*.prg" )
    FOR x := 1 TO Len( aDir )
        ? "Generate ", aDir[ x ][ F_NAME ], " Result : "
        IF Type( hb_FNameName( aDir[ x ][ F_NAME ] ) + "()" ) == "UI"
            ?? "Fail : Function alread exists"
        ELSE
            cCode := ( hb_MemoRead( "preload" + hb_ps() + aDir[ x ][ F_NAME ] ) )
            BEGIN SEQUENCE WITH __BreakBlock()
                pPointer := hb_compileFromBuf( cCode , "harbour" , "-q0", "-m" , "-n" )
                P_Hrb[ hb_FNameName( aDir[ x ][ F_NAME ] ) ] := hb_hrbLoad( pPointer )
            RECOVER USING oErr
                ?? "Error : " , oErr:Description , oErr:operation 
                QUIT
            END SEQUENCE
            
            IF ! Empty( P_Hrb[ hb_FNameName( aDir[ x ][ F_NAME ] ) ] )
                
                IF Type( hb_FNameName( aDir[ x ][ F_NAME ] ) + "()"  ) = "UI"
                    ?? "Ok"
                ELSE
                    ?? "Function not loaded."
                  
                ENDIF
            ELSE
                ?? "FAIL"
            ENDIF
        ENDIF
    NEXT
    ? "****************************************************************************"

return