REQUEST HB_CODEPAGE_UTF8 // Para a acentuação correta
#define COLUNA1 1
#define COLUNA2 COLUNA1 + 1
#define COLUNA3 COLUNA2 + 1
#define COLUNA4 COLUNA3 + 1
PROCEDURE Main()

    LOCAL oExcel := win_oleCreateObject( "Excel.Application" )
    LOCAL oSheet 
    LOCAL nLinha

    CriaArquivoParaTestes()
    USE excel
    hb_CdpSelect("UTF8") // Seleciono UTF-8
    IF oExcel  != NIL
        ? CurDir()
        oExcel:WorkBooks:Open( "C:\" + CurDir() + hb_ps() + "template01.xlsx")
        oSheet := oExcel:ActiveSheet()
        // Configura a fonte para todas as células
        oSheet:Cells:Font:Name := "Courier"
        oSheet:Cells:Font:Size := 12
        nLinha := 7 // Linha inicial
        DO WHILE .NOT. EOF()
            ? "Importando cliente : " , ALLTRIM( FIELD->NOME ) , " na linha " , nLinha
            oSheet:Cells( nLinha, COLUNA1 ):Value := ;
                                            ALLTRIM(FIELD->NOME)
            oSheet:Cells( nLinha, COLUNA2 ):Value := FIELD->NASC
            oSheet:Cells( nLinha, COLUNA3 ):Value := FIELD->COMPRAS
            oSheet:Cells( nLinha, COLUNA4 ):Value := FIELD->VIP
            ++nLinha
            SKIP
        ENDDO    
        oExcel:Visible := .T.
    ELSE
       ? "Erro: MS Excel indisponível. [" + win_oleErrorText() + "]"
    ENDIF
 
RETURN

PROCEDURE CriaArquivoParaTestes()

    LOCAL aStruct := {}, X

    IF .NOT. FILE( "excel.dbf" )
        AADD( aStruct , {"NOME","C",40,0} )
        AADD( aStruct , {"NASC","D",8,0} )
        AADD( aStruct , {"COMPRAS","N",15,2} )
        AADD( aStruct , {"VIP","L",1,0} )

        DBCREATE( "excel" , aStruct )
        USE excel 
        FOR x := 1 TO 1000
            APPEND BLANK
            REPLACE NOME WITH "CLIENTE NOME " + STRZERO( x , 4 )
            REPLACE NASC WITH DATE() - ( 365*hb_RandomInt( 18 , 60 ) )
            REPLACE COMPRAS WITH hb_RandomInt( 500 , 10000 ) / 100
            REPLACE VIP WITH IIF( hb_RandomInt( 1 , 2) == 1 , .t. , .f. )
        NEXT    
        CLOSE
    ENDIF

RETURN