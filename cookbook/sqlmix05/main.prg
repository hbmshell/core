//REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "NOME", "C", 10, 0 } }

    FOR x := 1 TO LEN( aDriver )                       
        ? "Usando o driver " + aDriver[x]
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK

        BEGIN SEQUENCE WITH __BreakBlock()
           
            REPLACE NOME WITH NIL
            ? "Valor do campo : " , hb_ValToExp( FIELD->NOME )
            ? "Campo tipo : " , VALTYPE( FIELD->NOME ) 
              
        RECOVER USING oOBj
         
            ? hb_Valtoexp( oObj )

        END
    NEXT    

RETURN
 
 
 
 