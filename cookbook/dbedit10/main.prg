STATIC aCab, aPict, aField
STATIC nCol, nRow
PROCEDURE Main
    SET DELETE ON
    aCab := { "Nome" , "Peso"  }
    aField := { "NOME" , "PESO" }
    aPict := { "@S10" , "@RE 999.99"  }

    hb_cdpSelect("UTF8")
    CriaArquivo()
    USE ficha
    CLS
    @ (nRow:=4),(nCol:=2) to 16,61 
    DbEdit( ++nRow , ++nCol , 15 , 60 , aField , "MinhaFuncaoModo" , aPict, aCab )
    
RETURN
/*********************/
//#include "inkey.ch"
//#include "dbedit.ch"
//#include "setcurs.ch"
FUNCTION MinhaFuncaoModo( nModo , nColuna )

    LOCAL nRetorno := DE_CONT
    LOCAL GetList := {}
    LOCAL xGet // alteração
    LOCAL nCursor 
    LOCAL x, nRecNo, cField // inclusão
    
    
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
            case LASTKEY()==K_ENTER
                xGet := ;
                    FIELDGET( FIELDPOS(aField[nColuna]) ) 
                @ ROW(),COL() GET xGet ;
                              PICTURE aPict[nColuna] ;
                              COLOR "G/N"
                nCursor := SetCursor(SC_NORMAL)
                READ 
                SetCursor( nCursor )
                IF !(LASTKEY()==K_ESC)
                    FIELDPUT( FIELDPOS(aField[nColuna]), xGet )
                ENDIF
            case LASTKEY()==K_DEL
                IF Alert("Confirma a exclusão ?",{"Sim","Não"})==1
                    DELETE
                    nRetorno := DE_REFRESH
                ENDIF
            case LASTKEY()==K_INS
                
                nRecNo := RecNo()
                @ nRow+2,nCol+16 SAY ""
                Append Blank
                FOR x := 1 TO LEN( aField )
                    xGet := ;
                        FIELDGET( FIELDPOS(aField[nColuna]) ) 
                    @ ROW(),COL() GET xGet ;
                                  PICTURE aPict[nColuna] ;
                                  COLOR "G/N"
                    nCursor := SetCursor(SC_NORMAL)
                    READ 
                    SetCursor( nCursor )
                    IF !(LASTKEY()==K_ESC)
                        FIELDPUT( FIELDPOS(aField[nColuna]), xGet )
                    ENDIF
                NEXT x
                
                READ
                IF LASTKEY()==K_ESC
                    DELETE
                    Go nRecNo
                    RESTORE SCREEN FROM cTela
                ELSE
                    nRetorno := DE_REFRESH
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
