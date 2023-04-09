#!/usr/local/bin/hbmshell

*@comment
*Auto=Yes
**********************************************
* Name  : Hbm_browse
* Date  : 2023-04-08 - 20:50:49
* Notes : 
/*
   1. 
   2. 
*/
***********************************************
*@@comment

*@procedure_head
*Auto=Yes
#include 'hbmediator.ch' // Use --virtual-include command line parameter (to use embedded file header)
PROCEDURE Hbm_browse( ... )
*@@procedure_head

*@init
*Auto=Yes
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams 
    LOCAL aPipe, x 
*@@init

*@define_parameters
*Auto=No

    **************************************Templates***************************************
    * SHELL ADD PARAM "-first" TITLE "First" BOOLEAN // Logical parameter
    * SHELL ADD PARAM "-second" TITLE "Second" STRING DEFAULT "Default Value" // Default value
    * SHELL ADD PARAM "-third" TITLE "Third" STRING MANDATORY // Must be value
    ************************************************************************************
    
    SHELL ADD PARAM "-dbf" TITLE "DBF file" STRING MANDATORY
*@@define_parameters

*@get_parameters
*Auto=Yes
    SHELL PRINT HELP TO cPrintParams
    IF hb_AScan( hb_Acmdline() , "--help" ) <> 0
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    IF IS_PIPE_CONTENT()
        aadd(aData, __PIPE)
    ENDIF
    

    //SHELL DEBUG hParams
    //SHELL DEBUG aData
*@@get_parameters

*@core
*Auto=No

    **************************************Error Templates***************************************
    * SHELL ERROR "Message error" // Quit with error message
    * SHELL ERROR "Message error" ERRORCODE nError // Quit with error message and error level
    ************************************************************************************
    /**
    2. Receive dbf name 
    */
    cFileName := hb_FNameExtSetDef( hParams["-dbf"], ".dbf" )
    
    /**
    3. Check If exists structure (If not, exit)
    */
    IF FILE( cFileName )
        USE ( cFileName ) SHARED
        Browse()
        USE
    ELSE
        SHELL ERROR hb_strFormat("File %s doesn't exists",cFileName) 
    
    ENDIF

*@@core

*@help
*Auto=Yes

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objective : "
    ?
    ? "Note : Try --virtual-include to use embedded ch files "
    ? "Parameters"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN
