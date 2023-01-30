/*

Opcional

*/

PROCEDURE MAIN

    LOCAL cString
    LOCAL aResult
    LOCAL cRegex
    
    HB_CDPSELECT( "UTF8" )

    ? "https://aurelio.net/regex/guia/opcional.html"
    
    ? "Opcional: a experiente ? / O opcional é um quantificador que não esquenta a cabeça," 
    ? "para ele pode ter ou não a ocorrência da entidade anterior, pois ele a repete 0 ou 1 vez."
    ? cRegex := "</?a>" 
    cRegex := HB_RegexComp( cRegex )
    FOR EACH cString IN { "<a>" , "</a>" }
        ? "String : " , cString
        aResult := hb_Regex( cRegex, cString  ) 
        ? "Resultado : " , hb_ValToExp( aResult )
    NEXT
      
    RETURN
    
/*    
O opcional é opcional.
O opcional é útil para procurar palavras no singular e plural.
*/















*/
    
  