// Thanks: http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=26740#p158283
PROCEDURE MAIN
Local cUrl  := "https://www.timeanddate.com/worldclock/fullscreen.html?n=45"
Try
      oServer:= win_OleCreateObject( "MSXML2.ServerXMLHTTP.6.0")
Catch
      alert('Erro na Criação do Serviço')
      Return .f.
End
Try
      oServer:Open( "GET", cUrl, .f. )
      oServer:SetRequestHeader( "Content-Type", "application/x-www-form-urlencoded" )
      oServer:SetRequestHeader( "Connection", "keep-alive" )
      oServer:Send()
      oServer:WaitForResponse( 5000 )
Catch
      Alert('Erro na Conexão com o Site')
      Return .f.
End
cRet   := oServer:ResponseBody
//   MemoWrit("site.txt", cRet)


   nIni  := At('</div><div id=i_date>',  cRet) + 21
   cHtml1:= SubStr( cRet, nIni)
   nFim  := At('</div><div id=i_time>', cHtml1) - 1
   ? SubStr(cRet, nIni, nFim)

   nIni := At('</div><div id=i_time>',  cRet) + 21
   cHtml1:= SubStr( cRet, nIni)
   nFim := At('</div><div id=i_timea>', cHtml1) - 1
   ? SubStr(cRet, nIni, nFim)