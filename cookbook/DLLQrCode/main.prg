
FUNCTION Main()

   /*
   cStr:= '3188075019|120.54|22/04/2014' 
   cFile:= "out.bmp" 
   nRet := CallDll32("FastQRCode","QRCodeLib.Dll",@cStr,@cFile)
   IF FILE( cFile )
       ? cFile , "was generated"
   ELSE
       ? "Error : ", hb_ValToExp(nRet)
   ENDIF
   cSpc := Space(500)
   CallDll32("QRCodeLibVer","QRCodeLib.Dll",@cSpc)
   
   cSpc := Space(500)
   ? hb_DynCall( { "QRCodeLibVer", "QRCodeLib.dll" , HB_DYN_CTYPE_CHAR_PTR } , @cSpc )
   ? cSpc
   ?  HMG_CallDLL ( "QRCodeLib.dll" , HB_DYN_CTYPE_CHAR_PTR , "QRCodeLibVer" , @cSpc )
   ? cSpc
   */
   
   
   
   Local hHandleDll := 0, nColor := 0
   HB_SYMBOL_UNUSED( hHandleDll )
   HB_SYMBOL_UNUSED( nColor )
   hHandleDll := hb_LibLoad("QRCodeLib.dll")
   ? hb_DynCall( { "QRCodeLibVer", hHandleDll, HB_DYN_CALLCONV_STDCALL } )
   hb_LibFree( hHandleDll )

   
RETURN NIL



