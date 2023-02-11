REQUEST SQLMIX
PROCEDURE Main

    LOCAL aDriver := { "SQLMIX" , "DBFNTX" }, x
    LOCAL aStruct := { { "NOME", "C", 10, 0 } }

    ? "NÃO IREI GRAVAR, APENAS CRIAR O REGISTRO"
    FOR x := 1 TO LEN( aDriver )                       
        dbCreate( "agenda", aStruct , aDriver[x], .T.)
        APPEND BLANK
        ? "Usando o driver " + aDriver[x]
        ? "Campo tipo : " , VALTYPE( FIELD->NOME ) ,;
          " Tamanho : " , LEN( FIELD->NOME )
    NEXT    

RETURN
 
 