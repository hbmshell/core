REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "NOME", "C", 10, 0 } }
    LOCAL oObj

    ? "I WILL NOT RECORD, JUST CREATE THE RECORD"
    FOR x := 1 TO LEN( aDriver )   
        BEGIN SEQUENCE WITH __BreakBlock()                    
            dbCreate( "agenda", aStruct , aDriver[x], .T.)
        RECOVER USING oOBj
         
          ? oObj:Description

        END            
        APPEND BLANK
        ? "Using driver " + aDriver[x]
        BEGIN SEQUENCE WITH __BreakBlock()
           
            ? "Field type : " , VALTYPE( FIELD->NOME ) ,;
              "Field lenght : " , LEN( FIELD->NOME )
              
        RECOVER USING oOBj
         
          ? hb_Valtoexp( oObj )

        END
    NEXT    

RETURN
 
 