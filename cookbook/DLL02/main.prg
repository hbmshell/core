/*
 *
 * Copyright 2010 Viktor Szakats (vszakats.net/harbour)
 *
 */
 //https://github.com/harbour/core/blob/master/contrib/hbmisc/tests/calldll.prg

//#require "hbmisc"

PROCEDURE Main()

#if defined( __PLATFORM__WINDOWS )

   LOCAL nFlags

   nFlags := -1
   ? CallDll32( "InternetGetConnectedState", "wininet.dll", @nFlags, 0 )
   ? nFlags

#endif

   RETURN
