
FUNCTION Main()
Local buf
 
 
   buf := hb_compilebuf( "harbour", "sample.prg" , "-n", "-w1" , "-es2" ) // Compile
 
   ? "Executing:",  hb_HrbRun( buf )   
  
   ?
   ? "------------------------------------------------------------"
   ? "Function Olar is in memory ? " , Type( "Olar()" )=="UI" // This function doesn't stay in memory
   ? "Function EuExisto is in memory ? : " , Type( "EuExisto()" )=="UI"
   
Return Nil

function EuExisto

return nil
