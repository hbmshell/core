#include "dbstruct.ch"
PROCEDURE Hbm_Gen( ... )

    LOCAL field
    
    dbCreate( "novo.dbf" , { { "Name" , "C" , 30 , 0 }, { "SALARY" , "N" , 10 , 2 } } )

    USE ( "novo.dbf" ) SHARED
    ? PADR( "Name" , 20 ), "Type" , " Length" , "   Decimals"
    ? REPL( "-" , 20 ), "----" , "-------" , "-----------"
    
    FOR EACH field IN dbStruct()
        ? PADR( field[ DBS_NAME ] , 20 ), field[ DBS_TYPE ], field[ DBS_LEN ] , field[ DBS_DEC ]
    NEXT


    
RETURN 
//---------------------------------------------------------
