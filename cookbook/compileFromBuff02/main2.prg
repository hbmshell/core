

FUNCTION Main2()
Local buf, cBuf := ""

  
   cBuf += "Function Olar" + hb_eol()
   cBuf += "Return 2+'A'" + hb_eol() // <-- Error in 2 + 'A'
   buf := hb_compileFrombuf( cBuf , "/n" )
   ? "Executing inside main2:",  hb_HrbRun( buf )   
   
Return Nil
