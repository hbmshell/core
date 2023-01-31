/**



*/

PROCEDURE Main

    LOCAL aStruct := {}
    LOCAL x, nTot := 10

    AADD( aStruct , { "CODIGO" ,  "I:+" , 10 , 0 })
    AADD( aStruct , { "NOME" , "C" , 30 , 0 })

    dbCreate( "contatos" , aStruct )
    USE contatos
    FOR x := 1 TO nTot
        APPEND BLANK
        // The field CODIGO was saved automatically
        // it is only necessary to record the NOME
        REPLACE NOME WITH "CONTATO " + STRZERO( x , 3 )
    NEXT    
    
    GO TOP
    DO WHILE .NOT. EOF()
        ? FIELD->CODIGO , FIELD->NOME
        SKIP
    ENDDO

RETURN
