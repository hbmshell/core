// https://github.com/Petewg/harbour-core/wiki/hb_A
/**
Description
-----------
Alert and Hb_ALert

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL nOpc

#ifdef __PLATFORM__WINDOWS
    ? "Adjust screen in windows machine"
    SetMode(50,100)
#endif
    //hb_Alert([cMessage|aMessage], <aOptions>, [<cColorNorm>] [, <nDelay>]) 
    hb_Alert("This message;disapears in five seconds.;;Please wait",/*Options*/,/*Color*/, 5) 
    hb_Alert({"This message","in other color","Type any key"},,"g/n")
    nOpc := hb_Alert("Many options.",{"Option 1","Option 2","Option 3"}) 
    hb_Alert("Option : " + hb_ValToStr(nOpc) )
    /*
    hb_Alert( { "TXT" => "Other example;with hash (associative array)", ;
        "BTN" => {"Great","Cool"}, ;
        "TIM" => 3  } )
    */
RETURN
