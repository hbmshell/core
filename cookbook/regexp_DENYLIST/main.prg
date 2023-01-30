/*

Busca case insensitive

*/
REQUEST HB_CODEPAGE_UTF8
PROCEDURE MAIN

    LOCAL cString
    LOCAL aResult
    LOCAL cRegex
    
    HB_CDPSELECT( "UTF8" )

    ? "https://aurelio.net/regex/guia/lista-negada.html"
    
    ? "Lista negada: a experiente [^...] / Pelas suas más experiências passadas, sabe o que não serve para ela casar."
    ? cRegex := "[^0-9]" 
    cRegex := HB_RegexComp( cRegex )
    FOR EACH cString IN { "012345" , "123-456-987/345" , "" }
        ? "String : " , cString
        aResult := hb_Regex( cRegex, cString  ) 
        ? "Resultado : " , hb_ValToExp( aResult )
    NEXT
      
    RETURN
    
/*    
Uma lista negada segue todas as regras de uma lista normal.
Um ^ literal não deve ser o primeiro item da lista.
[:classes POSIX:] podem ser negadas.
A lista negada sempre deve casar algo.
*/
    
  