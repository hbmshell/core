
// http://www.pctoledo.com.br/forum/viewtopic.php?f=55&t=16654&p=103620&hilit=calldll32#p103620
PROCEDURE MAIN

   ? mywin_GetComputerName()
    
RETURN
    

FUNCTION mywin_GetComputerName()

   LOCAL cComputerName := Space(255), nSize := 250

   CallDll32( "GetComputerNameA", "kernel32.dll", @cComputerName, @nSize )
   RETURN cComputerName
