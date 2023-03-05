// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL cOldDirectory
    LOCAL cNew

#ifdef __PLATFORM__WINDOWS
    cNew := "C:\Users"
#else
    cNew := "/home"
#endif
    ? "Change to " + cNew
    cOldDirectory := hb_cwd(cNew)
    ? "Old directory : ", cOldDirectory

    // Change and Checking if sucess
    IF FError() != 0
       ? "Cannot set working directory to " + cNew
    ELSE
       ? "Working directory changed from " + cOldDirectory + " to " + cNew
    ENDIF

RETURN
