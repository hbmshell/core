

FUNCTION Main()
Local buf, cBuf := "", oErr

   hb_CdpSelect("UTF8")

   cBuf := hb_Memoread("main2.prg") 
   ? ProcName()
   ? "Before:"
   buf := hb_compileFrombuf( cBuf , "/n" )
 
   ? "Executing:",  hb_HrbRun( buf )   
  
   ?
   ? "------------------------------------------------------------"
   ? "Function Main2 is in memory ? " , Type( "Main2()" )=="UI" // This function doesn't stay in memory
   
Return Nil

