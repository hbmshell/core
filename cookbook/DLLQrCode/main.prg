
FUNCTION Main()

   
   cStr:= '3188075019|120.54|22/04/2014' 
   cFile:= "out.bmp" 
   nRet := CallDll32("FastQRCode","QRCodeLib.Dll",@cStr,@cFile)
   IF FILE( cFile )
       ? cFile , "was generated"
   ELSE
       ? "Error : ", hb_ValToExp(nRet)
   ENDIF
   
RETURN NIL



