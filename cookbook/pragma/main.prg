
PROCEDURE MAIN

     LOCAL cString

     //- File file.txt must be exists before all

     #pragma __streaminclude "file.txt" | cString := %s

     ? cString

RETURN
