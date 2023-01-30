/*

Search case insensitive

*/

PROCEDURE MAIN

    LOCAL cString
    LOCAL aResult
    LOCAL cRegex
    
    HB_CDPSELECT( "UTF8" )

    ? "https://aurelio.net/regex/guia/ponto.html"
    
    ? "O ponto : o necessitado (aceita tudo)"
    ? "nao, não e nÃo"
   
    FOR EACH cString IN { "Você não vai desistir" , "Vc nao vai desistir" , "Vc nÃo vai desistir" }
        cRegex := "n.o" 
        cRegex := HB_RegexComp( cRegex )
        aResult := hb_Regex( cRegex, cString  ) 
        ? cString
        ? hb_ValToExp( aResult )
    NEXT
      
    RETURN
    
/*    
    O ponto casa com qualquer coisa.
    O ponto casa com o ponto.
    O ponto é um curinga para casar um caractere.
*/
    
  