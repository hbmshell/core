
REQUEST QOUT

FUNCTION Main()
Local buf, cBuf := "", oErr
 
   cBuf += "Procedure Olar" + hb_eol()
   cBuf += "Qout( 'testando!' )" + hb_eol()
 
   buf := hb_compileFrombuf( cBuf , "harbour" , "/n" )
 
   ? "Executing:"
   hb_HrbRun( buf )   
  
   ?
   ? "------------------------------------------------------------"
   ? "Type : " , Type( "Olar()" ) // This function doesn't stay in memory
   ? "Type : " , Type( "EuExisto()" )
   
Return Nil

function EuExisto

return nil