#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
PROCEDURE Hbm_GenExclui( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cSQL 
    LOCAL oObj
    LOCAL oCfg := VConfigMetaIgniter():New()
    LOCAL oSelect, cAuxMandatory  

    SHELL ADD PARAM "--table" TITLE "Nome da tabela" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 

    IF .NOT. oCfg:Init( hParams["--table"] ) // <----------- Inicializa os dados com a leitura do arquivo
        SHELL ERROR oCfg:GetLastMessage() ERRORCODE 102
    ENDIF    

    /* Iniciando o objeto gerador de código */
    oObj := VCodePrg():New( oCfg:getTableFrm() + "_exclui.prg" )
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
    oObj:WriteLN( "PROCEDURE " + oCfg:getTableFrm() + "Exclui( ... )" )
    oObj:WriteLN( "    MODULE SHELL" )
    oObj:WriteLN( "    LOCAL hParams , cPrintParams" )
    oObj:WriteLN( "    LOCAL cSQL, oObj" )
    oObj:EndBlock()

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

    oObj:IniBlock( "connect")
    oObj:WriteLN( '    DATABASE oObj' )
    oObj:WriteLN( '    oObj:Connect()' )
    oObj:WriteLN( '    IF oObj:Open()' )
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR CONNECT_ERROR_MESSAGE' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    ' )
    oObj:EndBlock()

    IF EMPTY( oCfg:getPkName() )
        SHELL MESSAGE ERROR "Chave primária não foi definida" ERRORCODE 111
    ENDIF    

    
    oObj:IniBlock( "checkdelete")
    oObj:WriteLN( '    oObj:SetQuery( "select * from ' + oCfg:getTableFrm() + ' where ' + oCfg:getPKName() + ' = " + VLJ_ValToSQL(hParams["--pkvalue"])  )' )
    oObj:WriteLN( '    IF oObj:ExecuteQueryToDBF("checkdelete")')
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()')
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    IF RECCOUNT() == 0')
    oObj:WriteLN( '        SHELL MESSAGE ERROR "Registro " + hParams["--pkvalue"] + " não existe" ERRORCODE 101') 
    oObj:WriteLN( '    ENDIF')
    oObj:EndBlock()


    oObj:IniBlock( "delete")
    oObj:WriteLN( '    IF oObj:DeleteSQL( "'+ oCfg:getTableFrm() + '" , "'+ oCfg:getPKName() +'" , hParams["--pkvalue"] )')
    oObj:WriteLN( '    ELSE')
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()')
    oObj:WriteLN( '    ENDIF')
    oObj:WriteLN( '    SHELL MESSAGE "Registro " +  hParams["--pkvalue"] + " foi excluído com sucesso."')    
    oObj:EndBlock()

    oObj:IniBlock( "help")
    oObj:WriteLN( 'STATIC PROCEDURE Hbm_Help( cPrintParams )')
    oObj:WriteLN( '    hb_Default( @cPrintParams , "")' )
    oObj:WriteLN( '    ? "Objetivo : Exclusão de dados na tabela ' + oCfg:getTableFrm() + '"')
    oObj:WriteLN( '    ?' )
    oObj:WriteLN( '    ? "Parâmetros"' )
    oObj:WriteLN( '    ? "[--help]    Help"' )
    oObj:WriteLN( '    IF .NOT. EMPTY( cPrintParams )' )
    oObj:WriteLN( '        ? cPrintParams' )
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    ? "Códigos de erro"' )
    oObj:WriteLN( '    ? "101 - O registro não foi excluído"' )
    oObj:WriteLN( '    QUIT' )
    oObj:WriteLN( "RETURN" )
    oObj:EndBlock()
#ifndef __PLATFORM__WINDOWS
    RUN ( "chmod +x "  +  oCfg:getTableFrm() + "_exclui.prg" ) 
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
