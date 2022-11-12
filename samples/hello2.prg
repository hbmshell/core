
//-q0
PROCEDURE Main( ... )
    
#ifdef __PLATFORM__WINDOWS
    SetMode(25,80)
#endif
    CLS
    hb_Alert( "Hello World" )

RETURN 
