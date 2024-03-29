PROCEDURE Main

    CriaArquivo()
    USE ficha
    CLS
    DbEdit()
    
RETURN
/*********************/
PROCEDURE CriaArquivo()

    LOCAL x, aStruct := {  { "NOME" , "C" , 50, 0 },;
                    { "NASCIMENTO" , "D" , 8 , 0 },;
                    { "ALTURA" , "N" , 6 , 4 },;
                    { "PESO" , "N" , 6 , 2 } }
                    

    IF .NOT. FILE( "ficha.dbf" )
       DBCREATE( "ficha" , aStruct )
       USE ficha NEW
       FOR x := 1 TO 50
          APPEND BLANK
          REPLACE NOME WITH "NOME " + STRZERO( x , 5 ) 
          REPLACE NASCIMENTO WITH ;
                    DATE() - ( 365 * hb_RandomInt( 0 , x ) )
          REPLACE ALTURA WITH 1.6 + hb_RandomInt( 1 , x ) / 100 
          REPLACE PESO WITH 30+hb_RandomInt( 10 , x + 11 )
          SKIP 
       NEXT
       USE 
    ENDIF     

RETURN    
/*********************/
