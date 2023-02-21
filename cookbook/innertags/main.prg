
/*

Pegando o conteúdo entre as tags

*/
REQUEST HB_CODEPAGE_UTF8
PROCEDURE MAIN

    LOCAL cString
    LOCAL aResult
    LOCAL cRegex
    
    HB_CDPSELECT( "UTF8" )

    ? "Entre tags"
    
    ? cRegex := "#(.*?)#" 
    cRegex := HB_RegexComp( cRegex )
    FOR EACH cString IN { "   #Grid_Frete#   " , "    #70    " , "  #7777770#     #80#" , "COD7770" }
        ? "String : " , cString
        aResult := hb_Regex( cRegex, cString  ) 
        ? "Resultado : " , hb_ValToExp( aResult )
    NEXT
      
    RETURN
    
    
  