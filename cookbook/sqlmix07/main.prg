REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "IDADE", "N", 2, 0 } }

    FOR x := 1 TO LEN( aDriver )                       
        ? "Usando o driver " + aDriver[x]
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK
        REPLACE IDADE WITH 1000
        ? "Valor do campo : " , hb_ValToExp( FIELD->IDADE )
        ? "Campo tipo : " , VALTYPE( FIELD->IDADE ) 
    NEXT    

RETURN
 
 
 
 