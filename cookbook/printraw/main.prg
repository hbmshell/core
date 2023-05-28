
PROCEDURE MAIN
     local cPrinter   := win_PrinterGetDefault()  
     local cFile := "nota.txt" 

     win_PrintDataRaw( cPrinter, cFile, "Impressao De Documentos" )
     ? wapi_GetLastError()

RETURN
