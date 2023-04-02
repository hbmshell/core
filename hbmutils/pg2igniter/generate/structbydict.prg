#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "dbstruct.ch"
PROCEDURE Hbm_StructByDict( ... )
    MODULE SHELL
    LOCAL hParams , cPrintParams
    LOCAL oObj
    LOCAL field
    
    SHELL ADD PARAM "--table" TITLE "Nome da tabela" MANDATORY REQUIRE VALUE
    SHELL ADD PARAM "--count-fields" TITLE "Quantidade de campos" 
    SHELL PRINT HELP TO cPrintParams
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF
    SHELL GET PARAMS TO hParams

    IF FILE( "dic_tables.dbf" ) .AND. FILE( "dic_tables_col.dbf" )
    ELSE     
        SHELL ERROR "As tabelas do dicionário não foram encontradas" ERRORCODE 100
    ENDIF
    USE ( "dic_tables_col" ) SHARED
    SET FILTER TO LOWER( ALLTRIM( FIELD->TTABLE )) == LOWER( hParams["--table"] )
    GO TOP
    IF hParams["--count-fields"]
        nContagem := 0
        DO WHILE .NOT. EOF()
            ++nContagem
            SKIP
        ENDDO
        ? ALLTRIM( Str( nContagem ) )   
        QUIT
    ENDIF    
    GO TOP
    IF EOF()
        SHELL ERROR "Tabela " + hParams["--table"] + " não foi encontrada no dicionário" ERRORCODE 101
    ENDIF
    ? "CREATE TABLE " + hParams["--table"] + " ( "
    DO WHILE .NOT. EOF()
        cProp := ""
        DO CASE
        CASE FIELD->TTYPE = "C"
            cProp := " VARCHAR( 100 ) "
        CASE FIELD->TTYPE = "N"
            cProp := " DECIMAL( 12,2 ) "
        CASE FIELD->TTYPE = "L"
            cProp := " BOOLEAN "
        CASE FIELD->TTYPE = "M"
            cProp := " TEXT "
        CASE FIELD->TTYPE = "D"
            cProp := " DATE "
        ENDCASE   
        
        IF FIELD->PK = "true"
            cProp += " PRIMARY KEY "
        ELSEIF FIELD->UK = "true"    
            cProp += " UNIQUE "
        ELSEIF FIELD->NONULL = "true"    
            cProp += " NOT NULL "
        ENDIF    
        ?? ALLTRIM( FIELD->TFIELD ) + cProp 
        SKIP
        IF EOF()
            ? ""
        ELSE
            ? ","    
        ENDIF    
    ENDDO    
    ? " ); " 
    // Chaves estrangeiras
    GO TOP
    DO WHILE .NOT. EOF()
        IF FIELD->FK = "true"
            ? "ALTER TABLE " + LOWER( ALLTRIM( FIELD->TTABLE )) + " ADD FOREIGN KEY ( " + ALLTRIM(LOWER(FIELD->TFIELD))+ ") REFERENCES "+ ALLTRIM(LOWER(FIELD->TABLE_REF))+" ( "+ALLTRIM(LOWER(FIELD->FIELD_REF))+" );"
        ENDIF    
        SKIP
    ENDDO    
    
RETURN 
//---------------------------------------------------------
STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "" )
    ? "Objetivo : Exibe a estrutura de um arquivo (.dbf)"
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN

