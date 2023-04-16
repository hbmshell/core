#!/usr/local/bin/hbmshell

*@comment
*Auto=Yes
**********************************************
* Name  : Hbm_nmap_scanner_ip
* Date  : 2023-04-16 - 02:46
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
PROCEDURE Hbm_nmap_scanner( ... )
*@@procedure_head

*@init
*Auto=No
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams
    LOCAL aIFace, aOpt := {} // Select option interface
    LOCAL cIp, aIp := {}, aInfo := {}
    local cerror, cresult
*@@init

*@define_parameters
*Auto=No


    SHELL ADD PARAM "-network" TITLE "Network (E.g: 24)" STRING
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

   
    
    /*
    Execute
    */
    ? "Scanning ", hParams["-network"]
    EXEC RUN "nmap" PARAMETERS "-sT", hParams["-network"] ERROR cError TO cResult
    
    
    /*
    4. Retorno
    */
    IF EMPTY( cError )
        SHELL MESSAGE cResult AS ARRAY
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
