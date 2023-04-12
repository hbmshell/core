//http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=26643
//To build: hbmk2 main.prg hbwin.hbc
PROCEDURE MAIN

    LOCAL cURL := "https://www.google.com.br"

#ifdef __PLATFORM__WINDOWS
    wapi_SHELLEXECUTE( cURL, "open", cURL, NIL, 2 )
#else
    ? "This script run only in Windows"
    WAIT
#endif

RETURN
