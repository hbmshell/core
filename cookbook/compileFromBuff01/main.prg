
FUNCTION Main()
Local buf, cBuf := "", oErr
 
   cBuf += "Function Olar" + hb_eol()
   cBuf += "Return 2+2" + hb_eol()
 
   buf := hb_compileFrombuf( cBuf , "/n" )
 
   ? "Executing:",  hb_HrbRun( buf )   
  
   ?
   ? "------------------------------------------------------------"
   ? "Function Olar is in memory ? " , Type( "Olar()" )=="UI" // This function doesn't stay in memory
   ? "Function EuExisto is in memory ? : " , Type( "EuExisto()" )=="UI"
   
Return Nil

function EuExisto

return nil