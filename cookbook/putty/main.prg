/* Get Putty in https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html */
procedure main

 cPrinterData := "Send to Putty (Client)"                                                                                                                   
 FWrite( 1, Chr( 27 ) + "[5i" + ; 
                 cPrinterData + ; 
                 Chr( 27 ) + "[4i" ) 

return
