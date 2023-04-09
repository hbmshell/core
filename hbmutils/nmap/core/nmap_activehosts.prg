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
PROCEDURE Hbm_nmap_activehosts( ... )
*@@procedure_head

*@init
*Auto=No
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams
    LOCAL aIFace, aOpt := {} // Select option interface
    LOCAL cIp
    local cerror, cresult
    LOCAL aStrDBF, lResultDBF
*@@init

*@define_parameters
*Auto=No

    **************************************Templates***************************************
    * SHELL ADD PARAM "-first" TITLE "First" BOOLEAN // Logical parameter
    * SHELL ADD PARAM "-second" TITLE "Second" STRING DEFAULT "Default Value" // Default value
    * SHELL ADD PARAM "-third" TITLE "Third" STRING MANDATORY // Must be value
    ************************************************************************************
    SHELL ADD PARAM "-ip" TITLE "IP address" STRING DEFAULT "myip"
    SHELL ADD PARAM "-net" TITLE "Network (E.g: 24)" STRING DEFAULT "24"
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

    **************************************Error Templates***************************************
    * SHELL ERROR "Message error" // Quit with error message
    * SHELL ERROR "Message error" ERRORCODE nError // Quit with error message and error level
    ************************************************************************************
    
    /*
    1. Get IP
    */
    IF hParams["-ip"]=="myip"
        aIFace := hb_socketGetIFaces( , .t. )
        FOR x := 1 TO Len(aIFace) 
            ? x, "IP:", aIFace[x][ HB_SOCKET_IFINFO_ADDR ], ;
            " MAC:", aIFace[x][ HB_SOCKET_IFINFO_HWADDR ]
            AADD( aOpt, x )
        NEXT
        ? x, "Exit to O.S."
        AADD( aOpt, x )
        ?
        CMD CHOICE "Select option [1.." + hb_ntos(x) + "]" OPTIONS aOpt TO cOpt
        IF cOpt == hb_ntos(x)
            SHELL MESSAGE "Exiting to O.S."
        ENDIF
        cIp := aIFace[ Val(cOpt)][ HB_SOCKET_IFINFO_ADDR ]
    ELSE
        cIp := hParams["-ip"]
    ENDIF
    
    cIp := cIp + "/" + hParams["-net"]
    QOut( cIp , hb_eol() )
    
    /*
    2. Execute
    */
    EXEC RUN "nmap" PARAMETERS "-sP", cIp ERROR cError TO cResult
    
    
    /*
    3. Save in DBF
    */
    IF .NOT. EMPTY( cError )
    ELSE
        /*
        3.1. Create/Open
        */
        aStrDBF := {}
        AADD( aStrDBF , { "DATE" , "D" , 8 , 0 } )
        AADD( aStrDBF , { "TIME" , "C" , 8 , 0 } )
        AADD( aStrDBF , { "NET" , "C" , 50 , 0 } )
        AADD( aStrDBF , { "IP" , "C" , 20 , 0 } )
        AADD( aStrDBF , { "MAC" , "C" , 100 , 0 } )
        USE nmap STRUCT aStrDBF TO lResultDBF
        dDate := Date()
        cTime := Time()
        IF lResultDBF
            /*
            3.2. Convert to array before save
            */
            aResult := hb_ATokens( cResult , .t. )
            FOR x := 1 TO LEN( aResult )
                IF "Nmap scan report" $ aResult[x]
                    APPEND BLANK
                    REPLACE DATE WITH dDate
                    REPLACE TIME WITH cTime
                    REPLACE NET WITH cIp
                    REPLACE IP WITH Substr( aResult[x] , RAT( " " , aResult[x] ) + 1 )
                ENDIF
                IF "MAC Address" $ aResult[x]
                    REPLACE MAC WITH Substr( aResult[x] , Len("MAC Address:")+1 )
                ENDIF
            NEXT
        ENDIF
    ENDIF
    
    /*
    4. Retorno
    */
    IF EMPTY( cError )
        SHELL MESSAGE "Sucess"
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
