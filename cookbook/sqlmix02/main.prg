REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "NOME", "C", 20, 0 },;
                       { "TELEFONE", "C", 10, 0 } }
    
    FOR x := 1 TO LEN( aDriver )                       
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK
        REPLACE FIELD->NOME WITH "GERALDO"
        REPLACE FIELD->TELEFONE WITH "980768-9087"
        ? "Using driver " + aDriver[x]
        ? FIELD->NOME , LEN( FIELD->NOME )
        ? FIELD->TELEFONE, LEN( FIELD->TELEFONE)
    NEXT    

RETURN
 