
PROCEDURE Main()

    LOCAL oExcel := win_oleCreateObject( "Excel.Application" )
    LOCAL oSheet 

    IF oExcel  != NIL
        oExcel:Visible := .T.
        oExcel:WorkBooks:Add()
        oSheet := oExcel:ActiveSheet()
        oSheet:Cells( 1, 1 ):Value := "Hello World"
    ELSE
       ? "Error: . [" + win_oleErrorText() + "]"
    ENDIF
 
RETURN