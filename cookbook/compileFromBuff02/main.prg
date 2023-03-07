
FUNCTION Main()
Local buf
   
   buf := hb_compileFrombuf( hb_Memoread("main2.prg") , "/n" )
   ? "Executing:",  hb_HrbRun( buf )   
   
Return Nil

