REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "NOME", "C", 10, 0 } }
    
    FOR x := 1 TO LEN( aDriver )                       
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK
        REPLACE FIELD->NOME WITH "SUPERIOR AO TAMANHO DO CAMPO"
        ? "Usando o driver " + aDriver[x]
        ? FIELD->NOME , LEN( FIELD->NOME )
    NEXT    

RETURN
 
 