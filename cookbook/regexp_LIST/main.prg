/*

Busca case insensitive

*/
REQUEST HB_CODEPAGE_UTF8
PROCEDURE MAIN

    LOCAL cString
    LOCAL aResult
    LOCAL cRegex
    
    HB_CDPSELECT( "UTF8" )

    ? "https://aurelio.net/regex/guia/lista.html"
    
    ? "Lista: a exigente [...] /  A lista não casa com qualquer um. Ela sabe exatamente o que quer, e nada diferente daquilo"
    ? "Correspondência case insensitive"
    ? cRegex := "[Ss][Oo][Ll]" 
    cRegex := HB_RegexComp( cRegex )
    FOR EACH cString IN { "Quando o sol bater na janela do teu quarto" , "O SOL nasceu para todos!!" }
        ? cString
        aResult := hb_Regex( cRegex, cString  ) 
        ? hb_ValToExp( aResult )
    NEXT
      
    RETURN
    
/*    
    A lista casa com quem ela conhece e tem suas próprias regras.
    Dentro da lista, todo mundo é normal.
    Dentro da lista, traço indica intervalo.
    Um - literal deve ser o último item da lista.
    Um ] literal deve ser o primeiro item da lista.
    Os intervalos respeitam a tabela ASCII (não use A-z).
    [:classes POSIX:] incluem acentuação, A-Z não.
*/
    
  