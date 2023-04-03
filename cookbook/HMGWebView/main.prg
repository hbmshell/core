
#define BM_URL_TO_RUN "http://bernard.mouille.free.fr/"
#include <hmg.ch>
function Main()
   DEFINE WINDOW Win1 ;
      AT     0,0 ;
      WIDTH  1100 ;
      HEIGHT  600 ;
      TITLE  "Test ActiveX" ;
      MAIN

      @ 10, 10 ACTIVEX Test ;
         WIDTH  1060  ;
         HEIGHT  540  ;
         PROGID "shell.explorer.2"

   END WINDOW

   form_onOpen()
   Activate Window Win1
   return nil

function form_onOpen()
   Win1.Test.Object:Navigate( BM_URL_TO_RUN )
   return nil

// ********************************
// How to run this event function ?
// ********************************
function DocumentComplete(pDisp, URL)
  wapi_MessageBox( valtype( pDisp ) + " " + URL )
  return nil
