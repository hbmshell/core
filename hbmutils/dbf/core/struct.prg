#!/usr/local/bin/hbmshell

**********************************************
* Name  : Hbm_Struct
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
PROCEDURE Hbm_Struct( ... )
    MODULE SHELL
    
    LOCAL hParams , aData, cPrintParams, cListErrors 
    LOCAL cFileName
    LOCAL aStruct 
 
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
    3. Check If exists structure (If not, exit)
    */
    IF FILE( cFileName )
        USE ( cFileName ) SHARED
        aStruct := dbstruct()
        USE
    ELSE
        SHELL ERROR hb_strFormat("File %s doesn't exists",cFileName)  
    
    ENDIF
    
    /**
    4. Show structure
    */
    
    For x := 1 TO len( aStruct )
        WRITELN aStruct[x][DBS_NAME],aStruct[x][DBS_TYPE],aStruct[x][DBS_LEN],aStruct[x][DBS_DEC] 
    Next

    
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
