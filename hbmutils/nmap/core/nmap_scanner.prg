#!/usr/local/bin/hbmshell

*@comment
*Auto=Yes
**********************************************
* Name  : Hbm_nmap
* Date  : 2023-04-09 - 13:15:59
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


    SHELL ADD PARAM "-dbf" TITLE "Network (E.g: 24)" STRING DEFAULT "nmap.dbf"

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

    **************************************Error Templates***************************************
    * SHELL ERROR "Message error" // Quit with error message
    * SHELL ERROR "Message error" ERRORCODE nError // Quit with error message and error level
    ************************************************************************************
    
    /*
    1. Open DBF
    */
    IF FILE( hParams["-dbf"] )
        USE ( hParams["-dbf"] ) SHARED 
    ELSE
        SHELL ERROR hb_Strformat( "File %s not found. Use nmap_activehosts.prg.", hParams["-dbf"] )
    ENDIF
    
    /*
      Get IP
    */
    GO BOTTOM
    DO WHILE .NOT. BOF()
        AADD( aIp , alltrim( field->ip ) )
        aadd( aInfo, alltrim( field->desc ) )
        cDateTime := dtoc( field->date ) + " / " + time()
        SKIP -1
        
        IF cDateTime <> dtoc( field->date ) + " / " + time()
            exit
        endif
    enddo
    ? cDateTime
    
    for x := 1 to len( aIp )
        ? x, aIp[x], "---->", aInfo[x]
    next
    input "Type number to get information:" to x
    if x > 0 .and. x < len(aIp)
        cIp := aIp[x]
    else
        ?
        SHELL ERROR "Invalid number" 
    endif
    
    /*
    2. Execute
    */
    ? "Scanning ", cIp, aInfo[x]
    EXEC RUN "nmap" PARAMETERS "-sT", cIp ERROR cError TO cResult
    
    
    /*
    4. Retorno
    */
    IF EMPTY( cError )
        SHELL MESSAGE cResult
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
