//REQUEST SQLMIX
PROCEDURE Main

    LOCAL aStruct := { { "NOME", "C", 20, 0 },;
                       { "TELEFONE", "C", 10, 0 } }
    
    dbCreate( "agenda", aStruct , "SQLMIX", .T.)
    APPEND BLANK
    REPLACE FIELD->NOME WITH "GERALDO"
    REPLACE FIELD->TELEFONE WITH "980768-9087"
    ? FIELD->NOME, FIELD->TELEFONE
    ? "O arquivo tem " , RECCOUNT()	, " registro"

    

RETURN
 