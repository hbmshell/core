#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
PROCEDURE Gen_Script( ... )
    MODULE SHELL
    LOCAL cPrintParams, hParams
    LOCAL oObj
    LOCAL cFieldFK
    LOCAL aConsultasCriadas := {}
    LOCAL cDebug := ""
    LOCAL aTemGrid := {}
#ifdef __PLATFORM__WINDOWS
    LOCAL lWin := .t.
    LOCAL cComent := "REM "
    LOCAL cVarFolder := "hbmshell.exe ..\generate\"
#else
    LOCAL lWin := .f.
    LOCAL cComent := "#"
    LOCAL cVarFolder :=  "../generate/"
#endif
    IF hb_PValue( 1 ) == "--help"
        Hbm_Help()
    ENDIF  
    IF hb_PValue( 1 ) == "--debug"
        cDebug := " --debug "
    ENDIF  
    USE dic_tables_col NEW SHARED
    USE dic_views NEW SHARED
    oObj := VCodePrg():New( "generate" + iif( lWin , ".bat" , ".sh" ))
    oObj:SetIniBlock( cComent + "@" )
    oObj:SetEndBlock( cComent + "#@@" )
    oObj:SetAutomatic( "Auto" )
    oObj:WriteLN( cComent +' Esse script foi gerado automaticamente através do script gen_script.prg (juntamente com config.json)' )
    if lWin 
        oObj:WriteLN( '@ECHO OFF' )
        oObj:WriteLN( cVarFolder + 'chkconfig.prg' )
        oObj:WriteLN( 'IF %ERRORLEVEL% NEQ 0 EXIT /b 1' )
    else
        oObj:WriteLN( '#!/bin/bash' )
        oObj:WriteLN( cVarFolder + 'chkconfig.prg' )
        oObj:WriteLN( 'if [ "$?" != "0" ]; then' )
        oObj:WriteLN( '     exit' )
        oObj:WriteLN( 'fi' )
    endif


    oObj:WriteLN(  cComent + ' Gerando listas/grid' )
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->TCONTROL) == "BROWSER"
            /* Iniciando o objeto gerador de código */
            oObj:WriteLN( cVarFolder + 'gen_lista.prg ' + cDebug + ' --view ' + ALLTRIM(FIELD->VIEWNAME) + ;
                                                              ParametrosListaBrw(ALLTRIM(FIELD->VIEWNAME)) )
            oObj:WriteLN( cVarFolder + 'gen_php.prg ' + cDebug + '  --sufix ' + SUBSTR(ALLTRIM(FIELD->VIEWNAME),5) )
            oObj:WriteLN( cVarFolder + 'gen_relat.prg ' + cDebug + '  --view ' + ALLTRIM(FIELD->VIEWNAME) + ;
                ParametrosListaRpt(ALLTRIM(FIELD->VIEWNAME)) )     
            AADD( aTemGrid , SUBSTR(ALLTRIM(FIELD->VIEWNAME),5) )       
        ENDIF
        SKIP
    ENDDO  
    oObj:WriteLN( cComent + '# Gerando Forms isolados' )  
    GO TOP
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->TCONTROL) == "FORM"
            IF ascan( aTemGrid,SUBSTR(ALLTRIM(FIELD->VIEWNAME),5) ) == 0
                oObj:WriteLN( cVarFolder + 'gen_php.prg ' + cDebug + '  --sufix ' + SUBSTR(ALLTRIM(FIELD->VIEWNAME),5) )
            ENDIF                     
        ENDIF
        SKIP
    ENDDO    
    oObj:WriteLN( cComent + ' Gerando consulta, exclusão , inclusão e alteração' ) 
    GO TOP
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->TCONTROL) == "FORM"
            /* Iniciando o objeto gerador de código */
            oObj:WriteLN( cVarFolder + 'gen_inclui.prg ' + cDebug + '  --view ' + ALLTRIM(FIELD->VIEWNAME) )
            oObj:WriteLN( cVarFolder + 'gen_altera.prg ' + cDebug + '  --view ' + ALLTRIM(FIELD->VIEWNAME) )
            oObj:WriteLN( cVarFolder + 'gen_consulta.prg ' + cDebug + '  --view ' + ALLTRIM(FIELD->VIEWNAME) )
            oObj:WriteLN( cVarFolder + 'gen_exclui.prg ' + cDebug + '  --table ' + ALLTRIM(FIELD->TTABLE_FRM) )
        ENDIF
        SKIP
    ENDDO    
    oObj:WriteLN( cComent + ' Gerando chaves estrangeiras dos formulários' ) 
    GO TOP
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->TCONTROL) == "FORM" 
            /* Iniciando o objeto gerador de código */
            SELECT dic_tables_col 
            SET FILTER TO ALLTRIM(dic_views->TTABLE_FRM) == ALLTRIM( FIELD->TTABLE)
            GO TOP
            cFieldFK := ""
            DO WHILE .NOT. EOF() 
                cFieldFK := ALLTRIM( FIELD->FIELD_REF )
                IF .NOT. EMPTY( cFieldFK )
                    oObj:WriteLN( cVarFolder + 'gen_lista_fk.prg ' + cDebug + '  --table ' + ALLTRIM(dic_views->TTABLE_FRM) + ' --field ' + ALLTRIM( FIELD->TFIELD ) )
                    aadd( aConsultasCriadas ,  ALLTRIM(dic_views->TTABLE_FRM) + cFieldFK )
                ENDIF                   
                SKIP
            ENDDO    
            SET FILTER TO
            SELECT dic_views
             
        ENDIF
        SKIP
    ENDDO    

    oObj:WriteLN( cComent + ' Gerando chaves estrangeiras dos navegadores' ) 
    GO TOP
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->TCONTROL) == "BROWSER" 
            /* Iniciando o objeto gerador de código */
            SELECT dic_tables_col 
            SET FILTER TO ALLTRIM(dic_views->TTABLE_BRW) == ALLTRIM( FIELD->TTABLE)
            GO TOP
            cFieldFK := ""
            DO WHILE .NOT. EOF() 
                cFieldFK := ALLTRIM( FIELD->FIELD_REF )
                IF .NOT. EMPTY( cFieldFK )
                    IF ASCAN( aConsultasCriadas, ALLTRIM(dic_views->TTABLE_BRW) + cFieldFK ) == 0
                        oObj:WriteLN( cVarFolder + 'gen_lista_fk.prg  ' + cDebug + ' --table ' + ALLTRIM(dic_views->TTABLE_BRW) + ' --field ' + cFieldFK )
                    ENDIF    
                ENDIF                   
                SKIP
            ENDDO    
            SET FILTER TO
            SELECT dic_views
             
        ENDIF
        SKIP
    ENDDO    
#ifndef __PLATFORM__WINDOWS
    RUN ("chmod +755 generate.sh")
#endif
RETURN 
//---------------------------------------------------------
STATIC FUNCTION ParametrosListaBrw( cView )
    LOCAL cRet := "", hJson, cJson, cParam
#ifdef __PLATFORM__WINDOWS
    LOCAL lWin := .t.
#else
    LOCAL lWin := .f.
#endif

    IF FILE("config.json")
        hJson := hb_jsonDecode( MemoRead("config.json") )
        IF .NOT. hb_HHasKey( hJson , "brw" )
            RETURN cRet := ""
        ENDIF
        FOR EACH cJson IN hJson["brw"]
            IF cJson:__enumkey() == cView
                FOR EACH cParam IN cJson
                    IF VALTYPE(cParam) == "C"
                        cRet += ( " " + cParam:__enumkey() + ' "' + cParam + '" ' )
                    ENDIF
                NEXT
            ENDIF    
        NEXT
    ENDIF
    IF lWin
        cRet := StrTran( cRet, "%","%%")
    ENDIF

RETURN cRet
//---------------------------------------------------------
STATIC FUNCTION ParametrosListaRpt( cView )
    LOCAL cRet := "", hJson, cJson, cParam
#ifdef __PLATFORM__WINDOWS
    LOCAL lWin := .t.
#else
    LOCAL lWin := .f.
#endif
    
        IF FILE("config.json")
            hJson := hb_jsonDecode( MemoRead("config.json") )
            IF .NOT. hb_HHasKey( hJson , "rpt" )
                RETURN cRet := ""
            ENDIF
            FOR EACH cJson IN hJson["rpt"]
                IF cJson:__enumkey() == cView
                    FOR EACH cParam IN cJson
                        IF VALTYPE(cParam) == "C"
                            cRet += ( " " + cParam:__enumkey() + ' "' + cParam + '" ' )
                        ENDIF
                    NEXT
                ENDIF    
            NEXT
            FOR EACH cJson IN hJson["brw"]
                IF cJson:__enumkey() == cView
                    FOR EACH cParam IN cJson
                        IF VALTYPE(cParam) == "C"
                            cRet += ( " " + cParam:__enumkey() + ' "' + cParam + '" ' )
                        ENDIF
                    NEXT
                ENDIF    
            NEXT            
        ENDIF
        IF lWin
            cRet := StrTran( cRet, "%","%%")
        ENDIF
    
    RETURN cRet
   
//---------------------------------------------------------


  
    
    
//---------------------------------------------------------
STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "" )
    ? "Objetivo : Gerar o script generate.sh com a rotina de geração do sistema" 
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN

