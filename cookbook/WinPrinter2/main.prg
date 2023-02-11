
/*
  compilar usando: Hbmk2 exemplo.prg -lhbwin -lxhb
  http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=19039&p=154787&hilit=Raw#p154787
  
*/
Function Main()
 Local cPrinter
 Local cTexto := "Teste de impressão" + Hb_EOL()
 
 SetMOde(50,150)
 
 MemoWrit( "ArqPrin.Txt", cTexto )
 
 cPorta := PrnGetPort()

   cPrinter := PrinterPortToName( cPorta )


   // Grave o arquivo...

   PrintFileRaw( cPrinter, TrueName("MINUTA.TXT"), "Impressão de Vendas" )
   
Return 