
#xcommand TRY => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand ENDTRY => END
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
   oHttp:Open("GET",cUrl ,.f.)  // erro en el site
   oHttp:Send()
   cResp1 := oHttp:ResponseText()
Catch
  ? "Comunication Error (2)"
  return nil
End Try

? cResp1 

Return nil 