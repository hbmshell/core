
/*
  compilar usando: Hbmk2 exemplo.prg -lhbwin -lxhb
  http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=19039&p=154787&hilit=Raw#p154787
  
*/
Function Main()
 Local cPrinter
 Local aPrn := GetPrinters()

 If Empty( aPrn )
  Alert( "Nenhuma impressora Instalada" )
  Return Nil
 Endif

 ? "List printers : "
 FOR x := 1 TO LEN( aPrn )
    ? aPrn[x]
 NEXT

Return 