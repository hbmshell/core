#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
PROCEDURE Hbm_GenLista( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cSQL 
    LOCAL oObj
    LOCAL oCfg := VConfigMetaIgniter():New()
    LOCAL oSelect, cAuxMandatory, oStruct    
    LOCAL cParamWhere ,x, cParams
    LOCAL cRun, cCaption
    LOCAL cColRel, aExcField
    

    SHELL ADD PARAM "--view" TITLE "Nome da view" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    SHELL ADD PARAM "--orderby" TITLE "Classificação (order by)" DEFAULT "0"
    SHELL ADD PARAM "--where" TITLE "Where (Filtro)" DEFAULT ""
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 

    IF .NOT. oCfg:Init( SUBSTR( hParams["--view"] , 5 ) ) // <----------- Inicializa os dados com a leitura do arquivo
        SHELL ERROR oCfg:GetLastMessage() ERRORCODE 102
    ENDIF    

    /* Iniciando o objeto gerador de código */
    oObj := VCodePrg():New( "rpt_" + Substr( hParams["--view"] , 5 ) + ".prg" )
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
    oObj:WriteLN( "PROCEDURE " + "rpt_" + Substr( hParams["--view"] , 5 ) + "( ... )" )
    oObj:WriteLN( "    MODULE SHELL" )
    oObj:WriteLN( "    LOCAL hParams , cPrintParams" )
    oObj:WriteLN( "    LOCAL cSQL, cGroupBy, oObj, oObjRel, aReturn, hCol,lFiltro" )
    oObj:WriteLN( "    LOCAL hWhere := {=>}, cWhere, cRelName" )
    oObj:WriteLN( "    LOCAL oCfg := VConfigMeta():New(), oStruct, aStruct := {}")
    oObj:EndBlock()

    oObj:IniBlock( "loglevel")
    oObj:WriteLN( '    //CONFIG LOG LEVEL INFO // ERROR , FATAL , WARNING' )
    oObj:WriteLN( '    //CONFIG LOG DISPLAY ON // OFF' )
    oObj:EndBlock()

    oObj:IniBlock( "where_param")
    FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
        IF !( oSelect:getTable() == oCfg:getTableBrw() )
            oObj:WriteLN( '    SHELL ADD PARAM "--where_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '" TITLE "Filtra pelo campo ' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '" REQUIRE VALUE' )
        ENDIF
    NEXT        
    oObj:WriteLN( '    SHELL ADD PARAM "--where_wdescricao" TITLE "Filtra por uma palavra ou termo contido em : " REQUIRE VALUE' )
    oObj:EndBlock()

    oObj:IniBlock( "user_pre")
    oObj:WriteLN( '   // Your code here (Pre automatic code)' )
    oObj:EndBlock()

    oObj:IniBlock( "shell")
    oObj:WriteLN( '    SHELL ADD PARAM "--orderby" TITLE "Order by" DEFAULT "1"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--orientation" TITLE "Orientação (1=Retrato,2=Paisagem)" DEFAULT "1"' )
    oObj:WriteLN( '    SHELL ADD PARAM "--target" TITLE "Envio do arquivo para um determinado local" DEFAULT "./"' )
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
    FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
        IF !( oSelect:getTable() == oCfg:getTableBrw() )
            oObj:WriteLN( '    IF .NOT. EMPTY( hParams["--where_'+ oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  )  +'"])') 
            oObj:WriteLN( e"         cSQL += hb_StrFormat( \" and " + oCfg:getTableBrw() + '.' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + e" = '%s' \" , hParams[\"--where_" + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + e"\"] )" )     
            oObj:WriteLN( '    ENDIF' )
        ENDIF
    NEXT        
    oObj:EndBlock()

    
    oObj:IniBlock( "where_wdescricao")
    oObj:WriteLN(  '    IF .NOT. EMPTY( hParams["--where_wdescricao"])' )     
    cParamWhere := ""
    FOR x := 1 TO NumAt("%s", hParams["--where"] )
        cParamWhere += ' hParams["--where_wdescricao"]  ,'
    NEXT
    cParamWhere := Substr( cParamWhere , 1 , LEN( cParamWhere)-1 )    
    oObj:WriteLN(  e"        cSQL += hb_StrFormat( \" and " + hParams["--where"] + e" \" , " + cParamWhere + " )")
    oObj:WriteLN( '    ENDIF' )
    oObj:EndBlock()

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
    oObj:WriteLN( '    IF oObj:ExecuteQueryToDBF("' + hParams["--view"] + '")')
    oObj:WriteLN( '    ELSE' )
    oObj:WriteLN( '        SHELL MESSAGE ERROR oObj:GetLastMessage()')
    oObj:WriteLN( '    ENDIF' )
    oObj:EndBlock()

    oObj:IniBlock( "largura_col") 
    oObj:WriteLN( "    hCol := {=>}" )  
    FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
        cColRel := IIF( EMPTY( oSelect:getAlias() ) , oSelect:getName(), oSelect:getAlias() )
        aExcField :=  VLJ_ConfigJson2Value( "config.json" , {"rpt" , hParams["--view"] , "exclude-field" } , {} )
        IF ( ASCAN( aExcField , cColRel )  == 0 )
            IF .NOT. oSelect:getIsPK()
                oObj:WriteLN( '    hCol[ "' + cColRel + '"] := ' + hb_ValToStr( VLJ_ConfigJson2Value( "config.json" , {"rpt" , hParams["--view"] , "columns" , cColRel , "width" } , 30 )))
            ENDIF
        ENDIF   
    NEXT
    oObj:EndBlock()

    oObj:IniBlock( "relat")
    oObj:WriteLN( '    oObjRel := VPdfClassText():New( VAL(hParams["--orientation"]) , lUtf8 := .t. )')
    oObj:WriteLN( '    oObjRel:setSubject("'+ oCfg:getBrwCaption() +'")')
    oObj:WriteLN( '    oObjRel:setAuthor( HBM_ORGANIZACAO )')
    oObj:WriteLN( '    cRelName := hParams["--target"] + VLJ_Chave()+".pdf"')
    
    oObj:WriteLN( '    oObjRel:setFilename( cRelName )')
    oObj:WriteLN( '    oObjRel:setTitle( "'+ oCfg:getBrwCaption() +'" )')
    oObj:WriteLN( '    oObjRel:addHeaderMain( HBM_ORGANIZACAO,"",HB_DTOC(DATE(),"DD/MM/YYYY") + " - " + TIME()) ')

    oObj:WriteLN( '    lFiltro := .f.')
    oObj:WriteLN( '    IF .NOT. EMPTY( hParams["--where_wdescricao"] )')
    oObj:WriteLN( '        oObjRel:addHeaderMain("Filtro / Termo : " + hParams["--where_wdescricao"],"","") ')
    oObj:WriteLN( '        lFiltro := .t.')
    oObj:WriteLN( '    ENDIF')

    FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
        IF !( oSelect:getTable() == oCfg:getTableBrw() )
            cParams := 'hParams["--where_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable() ) + '"]'
            oObj:WriteLN( '    IF .NOT. EMPTY( ' + cParams + ')')
            cRun := 'VLJ_RUN( HBM_SHELL_EXEC + " " + HBM_SHELL_SCRIPT + "fk_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable() ) + '.prg",'
            cRun += '{ "--pkvalue" , ' 
            cRun += cParams
            cRun += ' } )'

            cCaption := oCfg:getTables()[ oCfg:getTableBrw() ]["Caption"] 
            //oObj:WriteLN( '        ' + cRun )
            oObj:WriteLN( '        oObjRel:addHeaderMain("Filtro por ' + cCaption + ' : " + ' + cRun + ',"","") '  ) 
            oObj:WriteLN( '        lFiltro := .t.')
            oObj:WriteLN( '    ENDIF')
        ENDIF
    NEXT        
    oObj:WriteLN( '    IF .NOT. lFiltro')
    oObj:WriteLN( '        oObjRel:addHeaderMain("Relatório sem filtros") ')
    oObj:WriteLN( '    ENDIF')
    

    FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
        cColRel := IIF( EMPTY( oSelect:getAlias() ) , oSelect:getName(), oSelect:getAlias() )
        aExcField :=  VLJ_ConfigJson2Value( "config.json" , {"rpt" , hParams["--view"] , "exclude-field" } , {} )
        IF ( ASCAN( aExcField , cColRel )  == 0 )
            IF .NOT. oSelect:getIsPK() //.AND. cColRel <> "__FUNCTION"
                //addColumn(cField,cCaption,nWidth,cPicture,cAlign,lSum)
                cCaption := VLJ_ConfigJson2Value( "config.json" , {"rpt" , hParams["--view"] , "columns" , cColRel , "caption" } , oSelect:getCaption() )
                cPict := VLJ_ConfigJson2Value( "config.json" , {"rpt" , hParams["--view"] , "columns" , cColRel , "pict" } , "@x" )
                cType := VLJ_ConfigJson2Value( "config.json" , {"rpt" , hParams["--view"] , "columns" , cColRel , "type" } , "C" )
                cAlign := "L"
                IF cType == "N"
                    cAlign := "R"
                ENDIF
                oObj:WriteLN( '    oObjRel:addColumn( "' + cColRel  + '" , "' + cCaption + '" , hCol[ "' + cColRel  + '"] , "'+cPict+'"  , "'+cAlign+'"  )')
            ENDIF   
        ENDIF
    NEXT
    oObj:WriteLN( GruposRpt(  hParams["--view"] ) )  

    oObj:WriteLN( '    oObjRel:Run()')
    oObj:WriteLN( '    oObjRel:End()')
    oObj:WriteLN( '    IF hParams["--json"]')
    oObj:WriteLN( '        SHELL MESSAGE { "Relat" => cRelName }')
    oObj:WriteLN( '    ELSE')
    oObj:WriteLN( '        SHELL MESSAGE cRelName')
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
    RUN ( "chmod +x "  +  "rpt_" + Substr( hParams["--view"] , 5 ) + ".prg" )
#endif
    // Fim
RETURN    

//---------------------------------------------------------
STATIC FUNCTION GruposRpt( cView )
    LOCAL cRet := "", hJson, cJson, aParam, x
    
        IF FILE("config.json")
            hJson := hb_jsonDecode( MemoRead("config.json") )
            FOR EACH cJson IN hJson["rpt"]
                IF cJson:__enumkey() == cView
                    FOR EACH aParam IN cJson
                        IF VALTYPE(aParam) == "A" .and. aParam:__enumkey() == "--groups"
                            FOR x := 1 TO LEN( aParam )
                                xParam := aParam[x]
                                cRet += ( '    oObjRel:addGroup( "' + xParam["fieldname"] + '" , "' + xParam["caption"] + '")' + hb_eol()  )
                            NEXT    
                        ENDIF
                    NEXT
                ENDIF    
            NEXT
        ENDIF
    
    RETURN cRet
   
//---------------------------------------------------------


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
