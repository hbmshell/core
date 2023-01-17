REQUEST HB_CODEPAGE_UTF8 // Para a acentuação correta
PROCEDURE Main()

    LOCAL oExcel := win_oleCreateObject( "Excel.Application" )
    LOCAL oSheet 

    hb_CdpSelect("UTF8") // Seleciono UTF-8
    IF oExcel  != NIL
        oExcel:Visible := .T.
        oExcel:WorkBooks:Add()
        oSheet := oExcel:ActiveSheet()
        // Configura a fonte para todas as células
        oSheet:Cells:Font:Name := "Courier"
        oSheet:Cells:Font:Size := 18

    ELSE
       ? "Erro: MS Excel indisponível. [" + win_oleErrorText() + "]"
    ENDIF
 
RETURN