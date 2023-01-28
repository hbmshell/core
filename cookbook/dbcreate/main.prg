

PROCEDURE MAIN
 
    DBCREATE( "novo"  , { { "OLA" , "C" , 20 , 0 } } )  
    IF .not. FILE( "novo.dbf" )
        ? "File not found"
        quit
    ENDIF    
    USE novo // or USE ( "novo" ) <---- File name in string format is valid too
    APPEND BLANK
    REPLACE OLA WITH "OLA PESSOAL"
    ? "Alias : " , Alias()
    ? "Reccount() : " , RECCOUNT()

RETURN
