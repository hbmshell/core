
#xcommand TRY => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand ENDTRY => END
/*
Para funcionar em windows 7 :

https://support.microsoft.com/pt-br/topic/atualizar-para-habilitar-o-tls-1-1-e-o-tls-1-2-como-protocolos-seguros-padr%C3%A3o-no-winhttp-no-windows-c4bd73d2-31d7-761e-0178-11268bb10392

//--caso precise setar header
*oHttp:SetRequestHeader( "Accept","application/json")
*oHttp:SetRequestHeader( "Content-Type","application/json")

*/
function Main()
Local oHttp,  cResp1 := "" , hJson := hash()
Local oError, cUrl

cUrl := "https://www.google.com"

Try
   oHttp := CreateObject("winhttp.winhttprequest.5.1")  
catch oError
   Try
      oHttp := CreateObject( 'MSXML2.ServerXMLHTTP.6.0' )  
      oHttp:SetTimeouts(40000,40000,40000,40000)
   Catch oError
    ? "Comunication Error"
   return nil
   end
end

Try
   oHttp:Open("GET",cUrl ,.f.)  
   oHttp:Send()
   cResp1 := oHttp:ResponseText()
Catch
  ? "Comunication Error (2)"
  return nil
End Try

? cResp1 

Return nil 