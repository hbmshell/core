/*
To build : hbmk2 main.prg hbmisc.hbc
*/
// Thanks !
//http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=14549
function Main()

local cUrlFile := "https://www.google.com/"
local cLocalFile := "google.html"

IF wapi_UrlDownloadToFile( cUrlFile, cLocalFile )
    ? "Ok"
ENDIF

Return nil

FUNCTION wapi_UrlDownloadToFile( cUrlFile, cLocalFile )
   LOCAL nErrorCode
   nErrorCode := CallDll32( "URLDownloadToFileA", "urlmon.dll", 0, cUrlFile, cLocalFile, 0, 0 )
   RETURN nErrorCode == 0 