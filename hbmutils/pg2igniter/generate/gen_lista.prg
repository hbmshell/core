#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
PROCEDURE Hbm_GenLista( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cSQL 
    LOCAL oObj
    LOCAL oCfg := VConfigMetaIgniter():New()
    LOCAL oSelect, cAuxMandatory, oStruct    
    LOCAL cParamWhere ,x
    LOCAL aJson, lDetail := .f.
    

    SHELL ADD PARAM "--view" TITLE "Nome da view" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    SHELL ADD PARAM "--orderby" TITLE "Classificação (order by)" DEFAULT "0"
    SHELL ADD PARAM "--where" TITLE "Where (Filtro)" DEFAULT ""
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 
    //? hParams["--where"]

    IF .NOT. oCfg:Init( SUBSTR( hParams["--view"] , 5 ) ) // <----------- Inicializa os dados com a leitura do arquivo
        SHELL ERROR oCfg:GetLastMessage() ERRORCODE 102
    ENDIF    

    IF .NOT. FILE("config.json")
        SHELL ERROR "Arquivo config.json não encontrado" ERRORCODE 102
    ENDIF 
    /* Checar se é tabela filha em master-detail */
    //hJson := hb_jsonDecode( MemoRead("config.json") )
    //aJson := hJson["master-detail"]
    aJson := Vlj_ConfigJson2Value( "config.json" , {"master-detail"} , {} )
    FOR x := 1 TO LEN( aJson ) 
        IF aJson[x]["detail"] == hParams["--view"] 
           lDetail := .t.
           EXIT
       ENDIF    
    NEXT

    /* Iniciando o objeto gerador de código */
    oObj := VCodePrg():New( hParams["--view"] + ".prg" )
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
    oObj:WriteLN( "PROCEDURE " + hParams["--view"] + "( ... )" )
    oObj:WriteLN( "    MODULE SHELL" )
    oObj:WriteLN( "    LOCAL hParams , cPrintParams" )
    oObj:WriteLN( "    LOCAL cSQL, cGroupBy, oObj, aReturn" )
    oObj:WriteLN( "    LOCAL hWhere := {=>}, cWhere" )
    oObj:WriteLN( "    LOCAL oCfg := VConfigMeta():New(), oStruct, aStruct := {}")
    oObj:EndBlock()

    oObj:IniBlock( "loglevel")
    oObj:WriteLN( '    //CONFIG LOG LEVEL INFO // ERROR , FATAL , WARNING' )
    oObj:WriteLN( '    //CONFIG LOG DISPLAY ON // OFF' )
    oObj:EndBlock()

    oObj:IniBlock( "where_param")
    IF lDetail
        oObj:WriteLN( '    SHELL ADD PARAM "--where_detail-fieldname" TITLE "Nome da chave estrangeira para filtrar pela tabela master" MANDATORY REQUIRE VALUE' )
        oObj:WriteLN( '    SHELL ADD PARAM "--where_detail-fieldvalue" TITLE "Valor da chave estrangeira para filtrar pela tabela master" MANDATORY REQUIRE VALUE' )
    ELSE    
        FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
            IF !( oSelect:getTable() == oCfg:getTableBrw() )
                oObj:WriteLN( '    SHELL ADD PARAM "--where_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '" TITLE "Filtra pelo campo ' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '" REQUIRE VALUE' )
            ENDIF
        NEXT        
        oObj:WriteLN( '    SHELL ADD PARAM "--where_wdescricao" TITLE "Filtra por uma palavra ou termo contido em : " REQUIRE VALUE' )
    ENDIF    
    oObj:EndBlock()

    oObj:IniBlock( "user_pre")
    oObj:WriteLN( '   // Your code here (Pre automatic code)' )
    oObj:EndBlock()

    oObj:IniBlock( "shell")
    oObj:WriteLN( '    SHELL ADD PARAM "--limit" TITLE "Quantidade de registros por página" DEFAULT "0"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--orderby" TITLE "Order by" DEFAULT "1"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--page" TITLE "Pagina a ser mostrada" DEFAULT "1"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--json" TITLE "Retorno no formato JSON"' )
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

    oObj:IniBlock( "ver_limit_page")    
    oObj:WriteLN( '    IF VAL(hParams["--page"]) > 1 .AND. VAL(hParams["--limit"]) == 0' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR "Página > 1 e com limite infinito. Dica: Informe --limit ou retire --page. Erro de paginação."' )
    oObj:WriteLN( '    ENDIF' )
    oObj:EndBlock()

    oObj:IniBlock( "get_struct")    
    FOR EACH oStruct IN oCfg:getColViewBrwAsArray()
        oObj:WriteLN( '        AADD( aStruct , { "'+  oStruct:getTable() + "." + oStruct:getName() + '", "' + oStruct:getType() + '" , ' + hb_StrFormat("%d",oStruct:getLen()) + ' } )' )    
    NEXT
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

    oObj:IniBlock( "params")
    oObj:WriteLN( '    oObj:SetLimit( VAL( hParams["--limit"] ) )' )
    oObj:WriteLN( '    TEXT TO VAR cSQL' )
    oObj:WriteLN( '         ' + oCfg:getViewCodeBrw() ) // StrTran( dic_views->VIEWCODE , ";" , "" ) )
    oObj:WriteLN( '    ENDTEXT' )
    oObj:WriteLN( '    cSQL := StrTran( cSQL , ";" , "" )' )
    oObj:WriteLN( '    cGroupBy := ""' )
    oObj:WriteLN( '    IF "GROUP BY" $ UPPER(cSQL)' )
    oObj:WriteLN( '        cGroupBy := SUBSTR( cSQL , AT("GROUP BY",cSQL) )' )
    oObj:WriteLN( '        cSQL := SUBSTR( cSQL , 1, AT("GROUP BY",cSQL)-1 )' )
    oObj:WriteLN( '    ENDIF' )
    oObj:EndBlock()

    oObj:IniBlock( "where_filter")
    
    oObj:WriteLN(  '    IF AT( " WHERE " , UPPER(cSQL) ) == 0' )             
    oObj:WriteLN(  "        cSQL += ' WHERE 1=1 '" )     
    oObj:WriteLN(  '    ENDIF' )             
        
    IF .NOT. lDetail
        FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
            IF !( oSelect:getTable() == oCfg:getTableBrw() )
                oObj:WriteLN( '    IF .NOT. EMPTY( hParams["--where_'+ oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  )  +'"])') 
                oObj:WriteLN( e"         cSQL += hb_StrFormat( \" and " + oCfg:getTableBrw() + '.' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + e" = '%s' \" , hParams[\"--where_" + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + e"\"] )" )     
                oObj:WriteLN( '    ENDIF' )
            ENDIF
        NEXT        
    ENDIF    
    oObj:EndBlock()

    IF lDetail
        oObj:IniBlock( "where_detail")
        oObj:WriteLN(  '      cSQL += "  AND  "' )
        oObj:WriteLN(  '      cSQL += "' + oCfg:getTableBrw() + '."' )
        oObj:WriteLN(  e"     cSQL += hParams[\"--where_detail-fieldname\"] + \" = '\" + hParams[\"--where_detail-fieldvalue\"] + \"'\"" )
        oObj:EndBlock()
    ELSE    
        oObj:IniBlock( "where_wdescricao")
        oObj:WriteLN(  '    IF .NOT. EMPTY( hParams["--where_wdescricao"])' )     
        cParamWhere := ""
        FOR x := 1 TO NumAt("%s", hParams["--where"] )
            cParamWhere += ' hParams["--where_wdescricao"]  ,'
        NEXT
      //  ? hParams["--where"]
        cParamWhere := Substr( cParamWhere , 1 , LEN( cParamWhere)-1 )    
        oObj:WriteLN(  '        cSQL += hb_StrFormat( " and ' + hParams["--where"] + ' " , ' + cParamWhere + " )")
        oObj:WriteLN( '    ENDIF' )
        oObj:EndBlock()
    ENDIF

    oObj:IniBlock( "groupby")
    oObj:WriteLN( '    cSQL += " " + cGroupBy' )
    oObj:EndBlock()
    
    oObj:IniBlock( "orderby")
    IF hParams["--orderby"] == "0"
        oObj:WriteLN( '    IF hParams["--orderby"] == "1"')
        oObj:WriteLN( '    ELSE')
        oObj:WriteLN( '         cSQL += " ORDER BY " + hParams["--orderby"]' )
        oObj:WriteLN( '    ENDIF')
    ELSE
        oObj:WriteLN( '    IF hParams["--orderby"] == "1"')
        oObj:WriteLN( '         cSQL += " ORDER BY ' + hParams["--orderby"] + '"' )
        oObj:WriteLN( '    ELSE')
        oObj:WriteLN( '         cSQL += " ORDER BY " + hParams["--orderby"]' )
        oObj:WriteLN( '    ENDIF')
    ENDIF
    oObj:EndBlock()

    oObj:IniBlock( "user_pos")
    oObj:WriteLN( '   // Your code here (Pos automatic code)' )
    oObj:EndBlock()



    oObj:IniBlock( "exec")
    oObj:WriteLN( '    // ? cSQL' )
    oObj:WriteLN( '    oObj:SetQuery( cSQL )' )
    oObj:WriteLN( '    IF oObj:ExecuteQueryToDBF("' + hParams["--view"] + '",VAL(hParams["--page"]) )')
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()')
    oObj:WriteLN( '    ENDIF' )
    oObj:WriteLN( '    IF hParams["--json"]')
    oObj:WriteLN( '        aReturn := VLJ_Dbf2Array()' )
    oObj:WriteLN( '        oObj:ExecuteQueryToDBF("' + hParams["--view"] + '",VAL(hParams["--page"])+1 )')        
    oObj:WriteLN( '        SHELL MESSAGE  { "SQL" => cSQL, "Struct" => aStruct, "Grid" => aReturn , "IsNextPage" => (IIF( RECCOUNT()>0 , .t. , .f. ) ) , "IsPreviousPage" => IIF( VAL(hParams["--page"]) > 1 , .t. , .f. ) }') 
    oObj:WriteLN( '    ELSE')
    oObj:WriteLN( '        SHELL MESSAGE Vlj_CMDLoop()')
    oObj:WriteLN( '    ENDIF')
    oObj:WriteLN( 'RETURN') 
    oObj:EndBlock()

    oObj:IniBlock( "help")
    oObj:WriteLN( 'STATIC PROCEDURE Hbm_Help( cPrintParams )')
    oObj:WriteLN( '    hb_Default( @cPrintParams , "")' )
    oObj:WriteLN( '    ? "Objetivo : "')
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
    RUN ( "chmod +x "  +  hParams["--view"] + ".prg" )
#endif
    // Fim
RETURN    

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objetivo :  Gerar o código fonte do grid referente a view."
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN
