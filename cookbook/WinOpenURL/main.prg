//http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=26643
PROCEDURE MAIN

    LOCAL cURL := "https://www.google.com.br"

#ifdef __PLATFORM__WINDOWS
    SHELLEXECUTE( cURL, "open", cURL, NIL, 2 )
#endif

RETURN