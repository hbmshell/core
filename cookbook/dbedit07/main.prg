PROCEDURE Main

    LOCAL aCab := { "NOME" , "PESO"  }
    LOCAL aPict := { "@S10" , "@RE 999.99"  }

    hb_cdpSelect("UTF8")
    CriaArquivo()
    USE ficha
    CLS
    @ 4,2 to 16,61 
    DbEdit( 5 , 3 , 15 , 60 , aCab , "MinhaFuncaoModo" , aPict )
    
RETURN
/*********************/
#include "inkey.ch"
#include "dbedit.ch"
FUNCTION MinhaFuncaoModo( nModo )

    LOCAL nRetorno := DE_CONT

    IF nModo == DE_HITTOP
        // Aqui você pode colocar
        // uma mensagem ou evento
        // relacionado ao INÍCIO <-----
        // do arquivo alcançado
    ELSEIF nModo == DE_HITBOTTOM
        // Aqui você pode colocar
        // uma mensagem ou evento
        // relacionado ao FINAL <------
        // do arquivo alcançado
    ELSEIF nModo == DE_EMPTY
        Alert("O arquivo está vazio") 
        nRetorno := DE_ABORT    
    ELSEIF nModo == DE_EXCEPT 
        do case
            case LASTKEY()==K_ESC
                IF Alert("Deseja sair do grid ?",{"Sim","Não"})==1
                    nRetorno := DE_ABORT
                ENDIF
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
