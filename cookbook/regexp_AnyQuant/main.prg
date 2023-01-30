/*

Asterisco

*/
REQUEST HB_CODEPAGE_UTF8
PROCEDURE MAIN

    LOCAL cString
    LOCAL aResult
    LOCAL cRegex
    
    HB_CDPSELECT( "UTF8" )

    ? "https://aurelio.net/regex/guia/asterisco.html"
    
    ? "A entidade anterior pode aparecer em qualquer quantidade." 
    ? cRegex := "7*0" 
    cRegex := HB_RegexComp( cRegex )
    FOR EACH cString IN { "0" , "70" , "7777770" , "COD7770" }
        ? "String : " , cString
        aResult := hb_Regex( cRegex, cString  ) 
        ? "Resultado : " , hb_ValToExp( aResult )
    NEXT
      
    RETURN
    
/*    
O asterisco repete em qualquer quantidade.
Quantificadores são gulosos.
O curinga .* é o tudo e o nada, qualquer coisa.
*/
    
  