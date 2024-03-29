#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
PROCEDURE Hbm_GenAltera( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cSQL 
    LOCAL oObj
    LOCAL oCfg := VConfigMetaIgniter():New()
    LOCAL oSelect, cAuxMandatory

    

    SHELL ADD PARAM "--view" TITLE "Nome da view" STRING MANDATORY // Obrigatório e deve informar um valor
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams
   
    IF .NOT. oCfg:Init( SUBSTR( hParams["--view"] , 5 ) ) // <----------- Inicializa os dados com a leitura do arquivo
        SHELL ERROR oCfg:GetLastMessage() ERRORCODE 102
    ENDIF    

    /* Iniciando o objeto gerador de código */
    oObj := VCodePrg():New( oCfg:getViewNameForm()  + "_altera.prg" )
    oObj:SetIniBlock( "@" )
    oObj:SetEndBlock( "@@" )
    oObj:SetAutomatic( "Auto" )

    oObj:WriteLN("#!/usr/local/bin/hbmediator/hbmshell ")
    oObj:WriteLN("-q0")
    oObj:WriteLN("-n")

    /* Bloco inicial */
    oObj:IniBlock( "include")
    oObj:WriteLN( "#include 'cmdterminal.ch'" )
    oObj:WriteLN( "#include 'vbase.ch'" )
    oObj:WriteLN( "#include 'dcufc.ch'")
    oObj:EndBlock()

    oObj:IniBlock( "init")
    oObj:WriteLN( "PROCEDURE " + oCfg:getViewNameForm() + "Altera( ... )" )
    oObj:WriteLN( "    MODULE SHELL" )
    oObj:WriteLN( "    LOCAL hParams , cPrintParams" )
    oObj:WriteLN( "    LOCAL cSQL, oObj" )
    oObj:WriteLN( "    LOCAL hData := {=>}, aFieldNameValue := {}, xField" )
    oObj:EndBlock()

    oObj:IniBlock( "user_pre")
    oObj:WriteLN( '   // Your code here (Pre automatic code)' )
    oObj:EndBlock()       

    oObj:IniBlock( "receive_data_to_update")
    FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
        IF .NOT. oSelect:getIsPK()
            IF oSelect:getType() == "L"
                oObj:WriteLN( '    SHELL ADD PARAM "--'+ LOWER( oSelect:getName() ) +'" TITLE "' + ;
                    oSelect:getCaption() + '"' )

            ELSE    
                cAuxMandatory := ""
                IF EMPTY( oSelect:getDefault() )
                    oObj:WriteLN( '    SHELL ADD PARAM "--'+ LOWER( oSelect:getName() ) +'" TITLE "' + ;
                        oSelect:getCaption() + '" ' + cAuxMandatory + ' REQUIRE VALUE' )
                ELSE
                    oObj:WriteLN( '    SHELL ADD PARAM "--'+ LOWER( oSelect:getName() ) +'" TITLE "' + ;
                        oSelect:getCaption() + '" DEFAULT ' + oSelect:getDefault() )

                ENDIF
            ENDIF        
        ENDIF
    NEXT   
    oObj:EndBlock()

    IF EMPTY( oCfg:getPkName() )
        SHELL MESSAGE ERROR "gen_altera.prg  (" + hParams["--view"] + ") : Chave primária não foi definida" ERRORCODE 111
    ENDIF    

    oObj:IniBlock( "shell")
    oObj:WriteLN( '    SHELL ADD PARAM "--json" TITLE "Retorno no formato JSON"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--pkvalue" TITLE "Valor da chave primária" MANDATORY REQUIRE VALUE' )
    oObj:WriteLN( '    SHELL ADD PARAM "--debug" TITLE "Ativa o modo de depuração (Gera arquivo de log com a data de hoje)"' )
    oObj:WriteLN( '' )
    oObj:WriteLN( '    SHELL PRINT HELP TO cPrintParams' )    
    oObj:WriteLN( '    IF hb_PValue(1) == "--help"' )
    oObj:WriteLN( '        Hbm_Help( cPrintParams )' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    SHELL GET PARAMS TO hParams')
    oObj:WriteLN( '    SHELL SET MESSAGE JSON hParams["--json"]')
    oObj:EndBlock()

    oObj:IniBlock( "loglevel")
    oObj:WriteLN( '    IF hParams["--debug"]' )
    oObj:WriteLN( '         CONFIG LOG LEVEL INFO // ERROR , FATAL , WARNING' )
    oObj:WriteLN( '         CONFIG LOG DISPLAY ON // OFF' )
    oObj:WriteLN( '    ENDIF' )
    oObj:EndBlock()    

    oObj:IniBlock( "error_message")
    oObj:WriteLN( '    SHELL ADD ERROR 101 MESSAGE "Erros durante a conexão ao banco de dados"' )
    oObj:WriteLN( '    SHELL ADD ERROR 102 MESSAGE "Nenhum campo foi informado para alterar"' )
    oObj:WriteLN( '    SHELL ADD ERROR 103 MESSAGE "Ao realizar um select, para verificar se o registro para alterar não existe, ocorreu um erro"' )
    oObj:WriteLN( '    SHELL ADD ERROR 104 MESSAGE "O registro para alterar não existe"' )
    oObj:WriteLN( '    SHELL ADD ERROR 105 MESSAGE "Erros durante a alteração dos dados no banco de dados"' )
    oObj:EndBlock()   
    

    oObj:IniBlock( "connect")
    oObj:WriteLN( '    DATABASE oObj' )
    oObj:WriteLN( '    oObj:Connect()' )
    oObj:WriteLN( '    IF oObj:Open()' )
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR CONNECT_ERROR_MESSAGE  ERRORCODE 101' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    ' )
    oObj:EndBlock()

    oObj:IniBlock( "get_values")
    FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
        IF .NOT. oSelect:getIsPK()
            oObj:WriteLN( '    IF VALTYPE(hParams["--' + LOWER( oSelect:getName() ) + '"])<>NIL' )
            oObj:WriteLN( '        hData["--' + LOWER( oSelect:getName() ) + '"] :=  hParams["--' + LOWER( oSelect:getName() ) + '"]')
            oObj:WriteLN( '    ENDIF')
        ENDIF    
    NEXT
    oObj:WriteLN('    IF EMPTY( hData )')
    oObj:WriteLN('        SHELL MESSAGE ERROR "Nenhum campo foi informado para alterar. Operação cancelada." ERRORCODE 102' )
    oObj:WriteLN('    ENDIF')
    oObj:EndBlock()
    
    oObj:IniBlock( "checkdelete")
    oObj:WriteLN( '    oObj:SetQuery( "select * from ' + oCfg:getTableFrm() + ' where ' + oCfg:getPkName() + ' = " + VLJ_ValToSQL(hParams["--pkvalue"])  )' )
    oObj:WriteLN( '    IF oObj:ExecuteQueryToDBF("checkdelete")')
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()  ERRORCODE 103')
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    IF RECCOUNT() == 0')
    oObj:WriteLN( '        SHELL MESSAGE ERROR "Registro " + hParams["--pkvalue"] + " não existe" ERRORCODE 104') 
    oObj:WriteLN( '    ENDIF')
    oObj:EndBlock()


    oObj:IniBlock( "save_data")
    oObj:WriteLN( '    FOR EACH xField IN hData')
    oObj:WriteLN( '        AADD( aFieldNameValue ,  { SUBSTR( xField:__enumkey() , 3 )  => xField } )')
    oObj:WriteLN( '    NEXT' )
    oObj:WriteLN( '    IF oObj:UpdateSQL( "'+oCfg:getTableFrm() +'" , "'+ oCfg:getPkName() +'" , hParams["--pkvalue"] , hb_ArrayToParams( aFieldNameValue ) )')
    oObj:WriteLN( '    ELSE')
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()  ERRORCODE 105')
    oObj:WriteLN( '    ENDIF')
    oObj:WriteLN( '    SHELL MESSAGE "Registro " +  hParams["--pkvalue"] + " foi alterado com sucesso."')

    oObj:EndBlock()

    oObj:IniBlock( "help")
    oObj:WriteLN( 'STATIC PROCEDURE Hbm_Help( cPrintParams )')
    oObj:WriteLN( '    hb_Default( @cPrintParams , "")' )
    oObj:WriteLN( '    ? "Objetivo : Alteração de dados na tabela ' + oCfg:getTableFrm() + '"')
    oObj:WriteLN( '    ?' )
    oObj:WriteLN( '    ? "Parâmetros"' )
    oObj:WriteLN( '    ? "[--help]    Help"' )
    oObj:WriteLN( '    IF .NOT. EMPTY( cPrintParams )' )
    oObj:WriteLN( '        ? cPrintParams' )
    oObj:WriteLN( '    ENDIF' )
 
   
    oObj:WriteLN( '    QUIT' )
    oObj:WriteLN( "RETURN" )
    oObj:EndBlock()

#ifndef __PLATFORM__WINDOWS
    RUN ( "chmod +x "  +  hParams["--view"] + "_altera.prg" ) 
#endif
 

RETURN    

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objetivo :  Gerar o código fonte da alteração de dados referente a view."
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN
