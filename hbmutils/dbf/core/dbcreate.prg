#!/usr/local/bin/hbmshell

**********************************************
* Name  : Hbm_dbcreate
* Date  : 2023-04-08 - 14:44:46
* Notes : Algorithm  
/*
   1. Accept parameters
   2. Receive dbf name
   3. If exists get structure
   4. Create virtual DBF with structure
   5. If Len Struct > 0 Then add fields to virtual structure
   6. Show/Modify structure
   7. Export virtual dbf to matrix
   8. Create or update structure
*/
***********************************************
#include 'hbmediator.ch' // 
#include 'dbstruct.ch'
#define FIELD_LEN_MAX 30
PROCEDURE Hbm_dbcreate( ... )
    MODULE SHELL
    MODULE ERRORLEVEL
    LOCAL hParams , aData, cPrintParams, cListErrors 
    LOCAL cFileName
    LOCAL aStruct 
    LOCAL nCursor
    LOCAL lResult

    **************************************Templates***************************************
    SHELL ADD PARAM "-dbf" TITLE "DBF Name" STRING MANDATORY // Must be value
    ************************************************************************************
    SHELL PRINT HELP TO cPrintParams
    IF hb_AScan( hb_Acmdline() , "--help" ) <> 0
        Hbm_Help( cPrintParams , cListErrors )
    ENDIF
    
    /**
    1. Accept parameters
    */
    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    
    /**
    2. Receive dbf name 
    */
    cFileName := hb_FNameExtSetDef( hParams["-dbf"], ".dbf" )
    
    /**
    3. If exists get structure
    */
    IF FILE( cFileName )
        USE ( cFileName ) SHARED
        aStruct := dbstruct()
        USE
    ELSE
        aStruct := {}
     
    ENDIF
    
    /**
    4. Create virtual DBF with structure
    */
    dbCreate( "struct", { {"FIELD_NAME","C",FIELD_LEN_MAX,0},;
                          {"FIELD_TYPE","C",1,0},;
                          {"FIELD_LEN","N",3,0},;
                          {"FIELD_DEC","N",3,0} } , "SQLMIX", .T.)
    
    /**
    5. If Len Struct > 0 Then add fields to virtual structure
    */
    IF Len(aStruct)>0
        For x := 1 TO len( aStruct )
            append blank
            replace field_name with PADR( aStruct[x][DBS_NAME] , FIELD_LEN_MAX )
            replace field_type with aStruct[x][DBS_TYPE]
            replace field_len with aStruct[x][DBS_LEN]
            replace field_dec with aStruct[x][DBS_DEC]
        Next
        go top
    ENDIF
    
    /**
    6. Show/Modify structure 
    */
    nCursor := SetCursor( 1 )
    Browse()
    SetCursor( nCursor )
    
    /**
    7. Export virtual dbf to matrix
    */
    aStruct := {}
    go top
    do while .not. eof()
        aadd( aStruct, { alltrim(field->field_name) , field->field_type, field->field_len, field-> field_dec } )
        skip
    enddo
    /**
    8. Create or update structure
    */
    USE (cFileName) STRUCT aStruct TO lResult
    IF lResult
        ? "Success"
    ELSE
        ? "Fail"
    ENDIF
    
    
    //SHELL DEBUG hParams
    //SHELL DEBUG aData

STATIC PROCEDURE Hbm_Help( cPrintParams , cListErrors )

    hb_Default( @cPrintParams , "");hb_Default( @cListErrors , "" )
    ? "Objective : "
    ?
    ? "Note : Try --virtual-include to use embedded ch files "
    ? "Parameters"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    IF .NOT. EMPTY( cListErrors )
        ? "Errors code"
        ? cListErrors
        ? ""
    ENDIF
    QUIT

RETURN
