*******************************************************************************************************************
Procedure Main
   prn_init()
   mk_qrcode("GENODE123XX,Täößüt Company LTD.,DE21301204000000012345,Código : 12345,https://www.google.com.br")
   prn_exit()
Return
*******************************************************************************************************************
Function mk_qrcode(ccString)
// GiroCode for SEPA Bank Account Transactions FORMAT used by Banking Apps
local qr_arr := {}
   for i = 1 to 5
      intpos := at(",",ccString)
      t_string := substr(ccString,1,intpos-1)
      aadd(qr_arr,t_string)
      ccString := right(ccString,len(ccString)-intpos)
   next i
   qr_feld01 := "BCD"            // Service
   qr_feld02 := "001"            // Version
   qr_feld03 := "1"              // Coding (1=UTF8)
   qr_feld04 := "SCT"            // Function (SEPA Credit Transfer)
   qr_feld05 := qr_arr[1]        // BIC
   qr_feld06 := qr_arr[2]        // Receiver Name
   qr_feld07 := qr_arr[3]        // IBAN
   qr_feld08 := qr_arr[4]        // Ammount
   qr_feld09 := "GDDS"           // Purpose Code
   qr_feld10 := "https://www.google.com.br"               // Mandat Reference
   qr_feld11 := qr_arr[5]        // Comment like e.g. Invoice Number
   qr_feld12 := ""               // Hint for users
   qr_string := qr_feld01+chr(10)+qr_feld02+chr(10)+qr_feld03+chr(10)+qr_feld04+chr(10)+;
                qr_feld05+chr(10)+qr_feld06+chr(10)+qr_feld07+chr(10)+qr_feld08+chr(10)+;
                qr_feld09+chr(10)+qr_feld10+chr(10)+qr_feld11+chr(10)+qr_feld12
   qr_string := hb_strToUTF8(qr_string,"DEWIN")
   if len(qr_string) >= 330
      alert("QR Code String to long: "+str(len(qr_string)))
   else
      EanQRCode(oPrn,130,300,1.2,qr_string,HB_WIN_RGB_BLACK,HB_ZEBRA_FLAG_QR_LEVEL_M)
   endif
RETURN NIL
*******************************************************************************************************************
Function EanQRCode(coPRN, nY, nX, nWidth, nQRCODE, nColor, iFlags)
Local hCODE,nRET
Local nLineWidth:=IIF(nWidth==NIL .OR. nWidth<1,1,nWidth)
Local nLineHeight:=nLineWidth
Local nSCALE:=7.2

hCODE:=hb_zebra_create_qrcode(nQRCODE,iFlags)

nY *= nSCALE
nLineWidth *= nSCALE

IF hCODE != NIL
   IF hb_zebra_geterror( hCODE ) == 0
      IF Empty( nLineHeight )
         nLineHeight := 16
      ENDIF
      IF hb_zebra_geterror( hCODE ) != 0
         RETURN HB_ZEBRA_ERROR_INVALIDZEBRA
      Endif
      nRET:=hb_zebra_draw( hCODE, {|x,y,w,h| coPRN:FillRect(Int( x + .5 ), Int( y + .5 ),;
            Int( x + .5 ) + Int( w ), Int( y + .5 ) + Int( h ) + 1,nColor) },;
            nX*nSCALE, nY, nLineWidth, nLineHeight*nSCALE )
   Endif
   hb_zebra_destroy( hCODE )
Endif
Return nRET
*************************************************************************************************************************
function prn_init
   Public cPrinter := GetDefaultPrinter()
   //Public cPrinter := "eDocPrintPro" // PDF Printer
   Public oPrn:= Win32Prn():New(cPrinter)
   oPrn:FormType := 9 // A4 form
   oPrn:LandScape := .f.
   oPrn:Copies := 1
   if !oPrn:Create()
      Alert("Printer Error! check printer.")
      return
   endif
   if !oPrn:StartDoc("QRTestPage")
      Alert("Printer Error! check printer.")
      oPrn:Destroy()
      return
   endif
Return
*******************************************************************************************************************
Function prn_exit
   oPrn:EndDoc() // call endpage() at least one time.
   oPrn:Destroy()
Return Nil
*******************************************************************************************************************
