#!/usr/local/bin/hbmshell

*@comment
*Auto=Yes
**********************************************
* Name  : Hbm_GetMyIP
* Date  : 2023-04-16 - 02:21
* Notes : 
/*
   1. 
   2. 
*/
***********************************************
*@@comment

*@procedure_head
*Auto=No
#include 'hbmediator.ch' // Use --virtual-include command line parameter (to use embedded file header)
#include "hbsocket.ch"
PROCEDURE Hbm_GetMyIP( ... )
*@@procedure_head

*@init
*Auto=No
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams
    LOCAL aIFace, aOpt := {} // Select option interface
    local cerror, cresult

*@@init

*@define_parameters
*Auto=No

    **************************************Templates***************************************
    * SHELL ADD PARAM "-first" TITLE "First" BOOLEAN // Logical parameter
    * SHELL ADD PARAM "-second" TITLE "Second" STRING DEFAULT "Default Value" // Default value
    * SHELL ADD PARAM "-third" TITLE "Third" STRING MANDATORY // Must be value
    ************************************************************************************
    SHELL ADD PARAM "-json" TITLE "Result in json format" BOOLEAN
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
        AAdd(aData,m->__PIPE)
        //PIPE TO <aArray> AS ARRAY
        //PIPE TO <cStr> AS STRING
    ENDIF

    //SHELL DEBUG hParams
    //SHELL DEBUG aData
*@@get_parameters

*@core
*Auto=Yes

    IF hParams["-json"]
        SHELL JSON ON
    ELSE
        SHELL JSON OFF
    ENDIF

    **************************************Error Templates***************************************
    * SHELL ERROR "Message error" // Quit with error message
    * SHELL ERROR "Message error" ERRORCODE nError // Quit with error message and error level
    ************************************************************************************
    
    /*
    Get IP
    */
    aIFace := hb_socketGetIFaces( , .t. )
    FOR x := 1 TO Len(aIFace) 
        AADD( aOpt, aIFace[x][ HB_SOCKET_IFINFO_ADDR ] )
    NEXT
    
    
    /*
    Retorno
    */
    IF EMPTY( cError )
        SHELL MESSAGE aOpt 
    ELSE
        SHELL ERROR cError
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
