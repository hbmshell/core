PROCEDURE Main()


    IF win_oleCreateObject( "Excel.Application" )  != NIL
       ? "This computer support MS Excel" 
    ELSE
       ? "Erro: this computer doesn't support MS Excel: [" + ;
                win_oleErrorText() + "]"
    ENDIF
 
RETURN