

FUNCTION Main2()
Local buf, cBuf := "", oErr

   hb_CdpSelect("UTF8")
   
   cBuf += "Function Olar" + hb_eol()
   cBuf += "Return 2+'A'" + hb_eol()
   VLJ_OutStd( "Return 2+'a'" )
   ? Procname()
   ? "Before:"
   buf := hb_compileFrombuf( cBuf , "/n" )
 
   VLJ_OutStd( "Executing:",  hb_HrbRun( buf )  )
  
   ?
   ? "------------------------------------------------------------"
   ? "Function Olar is in memory ? " , Type( "Olar()" )=="UI" // This function doesn't stay in memory
   ? "Function EuExisto is in memory ? : " , Type( "EuExisto()" )=="UI"
   
Return Nil

function EuExisto

return nil
