REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "NOME", "C", 10, 0 } }

    FOR x := 1 TO LEN( aDriver )                       
        ? "Usando o driver " + aDriver[x]
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK
        REPLACE NOME WITH 1000
        ? "Valor do campo : " , hb_ValToExp( FIELD->NOME )
        ? "Campo tipo : " , VALTYPE( FIELD->NOME ) 
    NEXT    

RETURN
 
 
 
 