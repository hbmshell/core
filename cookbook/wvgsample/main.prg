//http://harbourlanguage.blogspot.com/2010/04/harbour-gt.html
//REQUEST HB_GT_WVG_DEFAULT
//REQUEST HB_GT_WVG
#include "hbgtinfo.ch"
procedure main 

   set color to "N/W,N/BG,,,N/W*" 
   cls 
   SETMODE(25,80)
   hb_gtInfo( HB_GTI_ICONFILE, "searchWeb.ico" ) 
   hb_gtInfo( HB_GTI_WINTITLE, "Programm Title" ) 
   Hb_GtInfo( HB_GTI_SELECTCOPY,.T.) 
   Hb_GtInfo( HB_GTI_RESIZABLE, .T. ) 
   HB_GTINFO( HB_GTI_CLOSABLE, .T. )
   HB_GTINFO( HB_GTI_RESIZABLE, .T. )
   HB_GTINFO( HB_GTI_CODEPAGE, 255 )
   Hb_GTInfo(HB_GTI_MOUSESTATUS, 1 )
   ? "Screen width :  " , HB_GTINFO( HB_GTI_SCREENWIDTH, HB_GTINFO( HB_GTI_DESKTOPWIDTH ) )
   ? "Screen height : " , HB_GTINFO( HB_GTI_SCREENHEIGHT, HB_GTINFO( HB_GTI_DESKTOPHEIGHT ) - 50 )
   *SETMODE( GTINFO( GTI_DESKTOPROWS ) - 5, GTINFO( GTI_DESKTOPCOLS ) )
   HB_GTInfo(HB_GTI_FONTNAME, "Courier New")
   HB_GTInfo(HB_GTI_FONTQUALITY,HB_GTI_FONTQ_HIGH )
   
   // Hb_GtInfo( HB_GTI_FONTWIDTH, 18  )
   //   HB_GTInfo(HB_GTI_FONTSIZE, 32)

   // another intresting
    // HB_GtInfo( HB_GTI_ISFULLSCREEN, .T. )
    // hb_gtInfo( HB_GTI_RESIZEMODE, HB_GTI_RESIZEMODE_FONT )
    
    alert( "Type any key" )
    
   
return 
