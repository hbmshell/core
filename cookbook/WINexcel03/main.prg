REQUEST HB_CODEPAGE_UTF8 // Para a acentuação correta
PROCEDURE Main()

    LOCAL oExcel := win_oleCreateObject( "Excel.Application" )
    LOCAL oWorkBook
    LOCAL oSheet 
    LOCAL nI, nCount

    IF oExcel  != NIL
        ? "Accessing sheets"
        oExcel:Visible := .T.
        ? "First example"
        oWorkBook := oExcel:WorkBooks:Add()
        FOR EACH oSheet IN oWorkBook:WorkSheets()
            ? oSheet:Name()
        NEXT    
        ? "Second example"
        nCount := oWorkBook:WorkSheets:Count()
        FOR nI := 1 TO nCount
            ? oWorkBook:WorkSheets:Item( nI ):Name
        NEXT

    ELSE
       ? "Erro: MS Excel indisponível. [" + win_oleErrorText() + "]"
    ENDIF
 
RETURN