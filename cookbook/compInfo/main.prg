// http://www.elektrosoft.it/tutorials/harbour-how-to/harbour-how-to.asp#compilinginfo
/**
Description
-----------
Get compile information

hbmk2
-----
hbmk2 main

*/

#include "hbver.ch"

PROCEDURE Main()

   LOCAL k

   ? "Harbour build date:                " + hb_Version( HB_VERSION_BUILD_DATE_STR ) 
   ? "Major version number:              " , hb_Version( HB_VERSION_MAJOR )
   ? "Minor version number:              " , hb_Version( HB_VERSION_MINOR )
   ? "Revision number:                   " , hb_Version( HB_VERSION_RELEASE )
   ? "Build status:                      " , hb_Version( HB_VERSION_STATUS )
   ? "-------------------------------------------------------------------"
   for k = 0 TO 25
      ? k , hb_Version( k )
   next k
   ? "-------------------------------------------------------------------"
   ? "Compiler used:                     " , hb_Version( HB_VERSION_COMPILER ) 

   RETURN
