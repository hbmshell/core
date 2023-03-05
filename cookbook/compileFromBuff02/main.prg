
//#include "hbmediator.ch"
FUNCTION Main()
Local buf, cBuf := "", oErr

   
   hb_CdpSelect("UTF8")

   cBuf := hb_Memoread("main2.prg") 
   x :=  "A"+3+'A'
   ? x , valtype(x)
   ? "Teste:------------------> ", 'A'+2, Valtype('A'+2), valtype(2+'A')
   ? "Before:"
   buf := hb_compileFrombuf( cBuf , "/n" )
 
   ? "Executing:",  hb_HrbRun( buf )   
  
   ?
   ? "------------------------------------------------------------"
   ? "Function Main2 is in memory ? " , Type( "Main2()" )=="UI" // This function doesn't stay in memory
   
Return Nil

