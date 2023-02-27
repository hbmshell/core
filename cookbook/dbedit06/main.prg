
#include "inkey.ch"
#include "dbedit.ch"
PROCEDURE Main

    LOCAL aCab := { "NOME" , "PESO"  }
    LOCAL aPict := { "@S10" , "@RE 999.99"  }

    CriaArquivo()
    USE ficha
    CLS
    DbEdit( 5 , 3 , 15 , 80 , aCab , "MinhaFuncaoModo" , aPict )
    
RETURN
/*********************/
FUNCTION MinhaFuncaoModo( nModo )

    LOCAL nRetorno := 1

    IF nModo == DE_EXCEPT // Tecla de exceção pressionada
        do case
            case LASTKEY()==K_ESC
                nRetorno := 0
                
        endcase
    ENDIF

RETURN nRetorno
/*********************/
PROCEDURE CriaArquivo()

    LOCAL x, aStruct := {  { "NOME" , "C" , 50, 0 },;
                    { "NASCIMENTO" , "D" , 8 , 0 },;
                    { "ALTURA" , "N" , 6 , 4 },;
                    { "PESO" , "N" , 6 , 2 } }
                    

    
    DBCREATE( "ficha" , aStruct )
    USE ficha NEW
    FOR x := 1 TO 5
        APPEND BLANK
        REPLACE NOME WITH "NOME " + STRZERO( x , 5 ) 
        REPLACE NASCIMENTO WITH ;
                DATE() - ( 365 * hb_RandomInt( 0 , x ) )
        REPLACE ALTURA WITH 1.6 + hb_RandomInt( 1 , x ) / 100 
        REPLACE PESO WITH 30+hb_RandomInt( 10 , x + 11 )
        SKIP 
    NEXT
    USE 

RETURN    
/*********************/
