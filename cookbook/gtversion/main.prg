/**

Thanks!
-------


To build
--------

hbmk2 main.prg 

*/


// This lines bellow are Valid only in compile mode (hbmk2 main.prg) - Uncomment to use
//ANNOUNCE HB_GT_SYS 
// REQUEST HB_GT_GUI_DEFAULT 
// REQUEST HB_GT_WIN 
// REQUEST HB_GT_WVT
////////////////////////////
 
PROCEDURE Main

    ? HB_GTVERSION(), HB_GTVERSION(1) 
    ? "Type any key to exit"
    Inkey(0)
    
RETURN
