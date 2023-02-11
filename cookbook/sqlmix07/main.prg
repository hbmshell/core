REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "IDADE", "N", 2, 0 } }

    FOR x := 1 TO LEN( aDriver )                       
        ? "Usando o driver " + aDriver[x]
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK
       
        BEGIN SEQUENCE WITH __BreakBlock()
            REPLACE idade WITH 1000
        RECOVER USING oOBj
         
            ? "Error : " , oObj:Description

        END

        ? "Valor do campo : " , hb_ValToExp( FIELD->IDADE )
        ? "Campo tipo : " , VALTYPE( FIELD->IDADE ) 
    NEXT    

RETURN
 
 
 
 