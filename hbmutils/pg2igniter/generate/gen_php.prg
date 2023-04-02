#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "vbase.ch"
PROCEDURE Hbm_GenPHP( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cPathCodeigniter := "../codeigniter/app"
    LOCAL oCfg := VConfigMetaIgniter():New()
    LOCAL oObj
    LOCAL cSelect, hSelect
    LOCAL oSelect
    LOCAL cRequired
    LOCAL hJson, cJson, aJson
    LOCAL lMaster := .f., lDetail := .f.
    LOCAL cDetailTable := "", cDetailField:=""
    LOCAL cMasterTable := "", cMasterField:=""
    LOCAL cMasterView := "", cDetailView := ""
    LOCAL x
    LOCAL cLinkItens
    LOCAL lGeraForm := .t., lGeraDelete := .t.
    LOCAL lGeraInc := .t., lGeraAlt := .t.
    LOCAL lGeraGrid := .t.   

    SHELL ADD PARAM "--sufix" TITLE "Nome do sufixo" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    SHELL ADD PARAM "--igniter" TITLE "Path para a pasta app do codeigniter" REQUIRE VALUE 
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 
    hb_HGetDef( hParams , "--igniter" , cPathCodeigniter ) 

    IF .NOT. oCfg:Init(hParams["--sufix"] ) // <----------- Inicializa os dados com a leitura do arquivo
        SHELL ERROR oCfg:GetLastMessage() ERRORCODE 102
    ENDIF    
    CONFIG LOG LEVEL INFO // ERROR , FATAL , WARNING
    CONFIG LOG DISPLAY ON // OFF

    IF .NOT. FILE("config.json")
        SHELL ERROR "Arquivo config.json não encontrado" ERRORCODE 102
    ENDIF

    aJson := Vlj_ConfigJson2Value( "config.json" , {"master-detail"} , {} )
    FOR x := 1 TO LEN( aJson ) 
        IF aJson[x]["master"] == ("brw_"+hParams["--sufix"])
            lMaster := .t.
            cMasterTable := oCfg:getTableBrw()
            USE dic_views SHARED NEW
            LOCATE FOR aJson[x]["detail"] == ALLTRIM(FIELD->VIEWNAME)
            IF FOUND()
                cDetailTable := ALLTRIM(FIELD->TTABLE_BRW)
            ELSE
                SHELL ERROR "Não encontrei a tabela detalhe na relação view Mestre x Detalhe : " + aJson[x]["master"] + " / " + aJson[x]["detail"] 
            ENDIF    
            CLOSE dic_views
        ENDIF    
        IF aJson[x]["detail"] == ("brw_"+hParams["--sufix"])
           cDetailTable := oCfg:getTableBrw()
           lDetail := .t.
           USE dic_views SHARED NEW
           LOCATE FOR aJson[x]["master"] == ALLTRIM(FIELD->VIEWNAME)
           IF FOUND()
               cMasterTable := ALLTRIM(FIELD->TTABLE_BRW)
           ELSE
               SHELL ERROR "Não encontrei a tabela mestre na relação view Mestre x Detalhe : "+ aJson[x]["master"] + " / " + aJson[x]["detail"] 
           ENDIF    
           CLOSE dic_views
       ENDIF    
        IF ( aJson[x]["detail"] == ("brw_"+hParams["--sufix"]) .OR.;
           aJson[x]["master"] == ("brw_"+hParams["--sufix"]) ) 
            cMasterField := GetMasterField( cMasterTable , cDetailTable )
            cDetailField := GetDetailField( cMasterTable , cDetailTable )
            cMasterView := aJson[x]["master"]
            cDetailView := aJson[x]["detail"]
            EXIT
        ENDIF    
    NEXT
    if lDetail .or. lMaster
        //? "Olha ...: Somos a tabela ", IIF( lDetail , "Detalhe", "Mestre")
            //? "A tabela pai é : ", cMasterTable
            //? "A tabela filho é : ", cDetailTable
            
            //? "O campo na tabela pai é : ", cMasterField
            //? "O campo na tabela filho é : ", cDetailField
    endif

    IF EMPTY( oCfg:getTableFrm() )
        ? "Formulário não existe! Referente ao grid da tabela " + hParams["--sufix"] + " / Controller : " + oCfg:getControllerNameFile()
        lGeraForm := .f.
    ENDIF
    ? "----------------------------------",oCfg:getTableBrw()
    IF EMPTY( oCfg:getTableBrw() )
        ? "Grid não existe! Referente ao formulário da tabela " + hParams["--sufix"] + " / Controller : " + oCfg:getControllerNameFile()
        lGeraGrid := .f.
    ENDIF


    IF LOWER( Vlj_ConfigJson2Value( "config.json" , {"brw","brw_"+hParams["--sufix"],"--delete"} , "on" )) == "off"
        lGeraDelete := .f.
    ENDIF   
    
    if LOWER(Vlj_ConfigJson2Value("config.json",{"frm","frm_"+hParams["--sufix"],"inc"},"on"))=="off"
        lGeraInc := .f.
    endif
    if LOWER(Vlj_ConfigJson2Value("config.json",{"frm","frm_"+hParams["--sufix"],"alt"},"on"))=="off"
        lGeraAlt := .f.
    endif

   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // PHP
    // Controller
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ?? "Gerando ",oCfg:getControllerNameFile()
    oObj := VCodePhp():New( oCfg:getControllerNameFile() )
    oObj:WriteLN("<?php")
    oObj:WriteLN("namespace App\Controllers;")

    oObj:IniBlock( "cabecalho")
    oObj:WriteLN("//use CodeIgniter\Files\File;")
    oObj:EndBlock()    


    oObj:WriteLN("class " + oCfg:getControllerName()  + " extends BaseController")
    oObj:WriteLN("{")
    oObj:WriteLN("")

    IF lGeraGrid
        oObj:IniBlock( "lista")
        oObj:WriteLN('    public function lista( $page = 1 , $__STATE = "" )')
        oObj:WriteLN('    {')
        oObj:WriteLN('        $session = \Config\Services::session();')
        oObj:WriteLN('        if (!$session->get("login"))')
        oObj:WriteLN('             return redirect()->to( "authentic/" );')
        oObj:WriteLN('        if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
        oObj:WriteLN('             return redirect()->to( "authentic/acessonegado" );')      
        oObj:WriteLN('        helper("form");')
        
        IF lDetail
            cLinkItens := "/" + cDetailView + "/lista/1?md_" + cDetailTable + "_" + cDetailField + "=" + '<?=$linha["' + cMasterField + '"];?>'
            oObj:WriteLN('        $where["detail-fieldname"] = "'+cDetailField+'";')
            oObj:WriteLN('        if ( !empty( $this->request->getGet() ) ){')
            oObj:WriteLN('                $where["detail-fieldvalue"] = $this->request->getGet("md_' + cDetailTable + '_' + cDetailField + '");')            
            oObj:WriteLN('                $__STATE=status_encode( array( "where" => $where ) );')
            oObj:WriteLN('        } else {')
            oObj:WriteLN('                $json=status_decode($__STATE);')
            oObj:WriteLN('                if ( array_key_exists("where",$json)){')
            oObj:WriteLN('                    $where["detail-fieldvalue"] = $json["where"]["detail-fieldvalue"];')            
            oObj:WriteLN('                    $__STATE=status_encode( array( "where" => $where ) );')
            oObj:WriteLN('                } else {')
            oObj:WriteLN('                    $__STATE = status_encode( array() );')
            oObj:WriteLN('                }')
            oObj:WriteLN('        }')
            oObj:WriteLN('        $__STATE=status_encode( array( "where" => $where ) );')
            oObj:WriteLN('        $dados = grid("' + oCfg:getViewNameGrid() + '.prg" , $page , $__STATE , 99999999 );')
        ELSE    
            oObj:WriteLN('        if ( !empty( $this->request->getGet() ) ){')
            FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
                IF chkFkField( oCfg:getTableBrw() , oCfg:getPKNameFromTable( oSelect:getTable()  ) , oCfg ) 
                    IF !( oSelect:getTable() == oCfg:getTableBrw() )
                        oObj:WriteLN('            $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' = $this->request->getGet("fk_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '" );' )
                        oObj:WriteLN('            $where["' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '"] = $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' ;' )
                    ENDIF
                ENDIF
            NEXT        
            oObj:WriteLN('            $wdescricao = $this->request->getGet("wdescricao");')
            oObj:WriteLN('            $where["wdescricao"] = $wdescricao;')
            oObj:WriteLN('            $__STATE=status_encode( array( "where" => $where ) );')
            oObj:WriteLN('            $page=1;')    
            oObj:WriteLN('        } else {')
            FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
                IF chkFkField( oCfg:getTableBrw() , oCfg:getPKNameFromTable( oSelect:getTable()  ) , oCfg ) 
                    IF !( oSelect:getTable() == oCfg:getTableBrw() )
                        oObj:WriteLN('            $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' = "";' )
                    ENDIF
                ENDIF
            NEXT     
            oObj:WriteLN('            $wdescricao="";')   
            oObj:WriteLN('            if (empty($__STATE))' )
            oObj:WriteLN('                $__STATE = status_encode( array() );' )
            oObj:WriteLN('            else {' )
            oObj:WriteLN('                $json=status_decode($__STATE);' ) 
            oObj:WriteLN('                if ( array_key_exists("where",$json)){')   
            FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
                IF chkFkField( oCfg:getTableBrw() , oCfg:getPKNameFromTable( oSelect:getTable()  ), oCfg ) 
                    IF !( oSelect:getTable() == oCfg:getTableBrw() )
                        oObj:WriteLN('                    $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' = $json["where"]["' +  oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '"];' )
                    ENDIF
                ENDIF
            NEXT        
            oObj:WriteLN('                    // Descrição')
            oObj:WriteLN('                    $wdescricao=$json["where"]["wdescricao"];')
            oObj:WriteLN('                }')   
            oObj:WriteLN('            }' )
            oObj:WriteLN('        }')
            //-------------------- Script hbm_Shell
            oObj:WriteLN('        $dados = grid("' + oCfg:getViewNameGrid() + '.prg" , $page , $__STATE );')
            //--------------------------------------    
            oObj:WriteLN('        $dados["wdescricao"] = $wdescricao;')
            FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
                IF chkFkField( oCfg:getTableBrw() , oCfg:getPKNameFromTable( oSelect:getTable()  ) , oCfg) 
                    IF !( oSelect:getTable() == oCfg:getTableBrw() )
                        oObj:WriteLN('        $dados["' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '"] = $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ';' )
                    ENDIF
                ENDIF
            NEXT    
            FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
                IF chkFkField( oCfg:getTableBrw() , oCfg:getPKNameFromTable( oSelect:getTable()  ),oCfg ) 
                    IF !( oSelect:getTable() == oCfg:getTableBrw() )
                        oObj:WriteLN('        $dados["select_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '"] = fk( "' + ;
                            oCfg:getTableBrw() + '","' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '");' )
                    ENDIF
                ENDIF    
            NEXT
        ENDIF
        //-- A seguir temos os dados comuns a todos os tipos de tabelas (Master, Detail e Comum)
        oObj:WriteLN('        $dados["__LOGIN"] = $session->get("login");')        
        oObj:WriteLN('        $dados["__STATE"] = $__STATE;')    
        oObj:WriteLN('        $dados["titulo"] = "' + oCfg:getBrwCaption() + '";')
        oObj:WriteLN('        $dados["__PAGE"] = $page;')


        oObj:WriteLN('')

        IF lDetail
            oObj:WriteLN('        echo view("templates/header_item",$dados);')
        ELSE 
            oObj:WriteLN('        echo view("templates/header",$dados);')
        ENDIF    
        oObj:WriteLN('        echo view("' + oCfg:getViewNameGrid() + '", $dados);')
        oObj:WriteLN('        echo view("templates/footer");')
        oObj:WriteLN('')
        oObj:WriteLN('    }')
        oObj:EndBlock()    

        oObj:IniBlock( "rpt")
        oObj:WriteLN('    public function rpt( $page = 1 , $__STATE = "" )')
        oObj:WriteLN('    {')
        oObj:WriteLN('        $session = \Config\Services::session();')
        oObj:WriteLN('        if (!$session->get("login"))')
        oObj:WriteLN('             return redirect()->to( "authentic/" );')
        oObj:WriteLN('        if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
        oObj:WriteLN('             return redirect()->to( "authentic/acessonegado" );')      
        oObj:WriteLN('        if ( !empty( $this->request->getGet() ) ){')
        FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
            IF !( oSelect:getTable() == oCfg:getTableBrw() )
                oObj:WriteLN('            $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' = $this->request->getGet("fk_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '" );' )
                oObj:WriteLN('            $where["' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '"] = $' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' ;' )
            ENDIF
        NEXT        
        oObj:WriteLN('            $wdescricao = $this->request->getGet("wdescricao");')
        oObj:WriteLN('            $where["wdescricao"] = $wdescricao;')
        oObj:WriteLN('            $__STATE=status_encode( array( "where" => $where ) );')
        oObj:WriteLN('        } ')
        oObj:WriteLN('        $retorno = rpt("rpt_' + Substr( oCfg:getViewNameGrid() , 5 ) + '.prg" ,$__STATE );')
        oObj:WriteLN('        if ( $retorno["Result"] == "OK" )')
        oObj:WriteLN('            return $this->response->download( $retorno["Content"]["Relat"] , null );')
        oObj:WriteLN('        else {')
        oObj:WriteLN('            $dados[ "titulo" ] = "Erro ao gerar um relatório em PDF";')
        oObj:WriteLN('            $dados[ "mensagem" ] = $retorno["Content"];')
        oObj:WriteLN(e"            $dados[ \"retorno\" ] = \"javascript:history.back()\";" ) // $_SERVER['HTTP_REFERER'];")
        oObj:WriteLN('            echo view("templates/erro", $dados);')
        oObj:WriteLN('            return;')        
        oObj:WriteLN('        }')      

        oObj:WriteLN('    }')
        oObj:EndBlock()    
    ENDIF // lGeraGrid

    IF lGeraForm

        IF lGeraInc
        
            oObj:IniBlock( "valoresDefaultParaForminclui")
            oObj:WriteLN('    public function default()')
            oObj:WriteLN('    {')
            oObj:WriteLN('')
            FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
                IF oSelect:getType == "D" .AND. empty(oSelect:getDefault())
                    oObj:WriteLN('            $default["' + oSelect:getName() + '"] = date("Y-m-d");' )
                ELSEIF oSelect:getType == "N" .AND. empty(oSelect:getDefault())
                    oObj:WriteLN('            $default["' + oSelect:getName() + '"] = "0";' )            
                ELSE    
                    oObj:WriteLN('            $default["' + oSelect:getName() + '"] = "' + oSelect:getDefault() + '";' )
                ENDIF    
            NEXT
            oObj:WriteLN('')
            oObj:WriteLN('      return $default;')
            oObj:WriteLN('    }')
            oObj:EndBlock()


            oObj:IniBlock( "forminclui")
            oObj:WriteLN('    public function forminclui( $page = 1 , $__STATE = "" )')
            oObj:WriteLN('    {')
            oObj:WriteLN('        $session = \Config\Services::session();')
            oObj:WriteLN('        if (!$session->get("login"))')
            oObj:WriteLN('             return redirect()->to( "authentic/" );')
            oObj:WriteLN('        if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
            oObj:WriteLN('             return redirect()->to( "authentic/acessonegado" );')      
            oObj:WriteLN('        if (!$this->validate([])) {')
            oObj:WriteLN('            helper("form");')
            oObj:WriteLN('            $dados = [')
            oObj:WriteLN('                "oper" => "I",')
            oObj:WriteLN('                "titulo" => "Inclusão",')
            oObj:WriteLN('                "__PAGE" => $page,')
            oObj:WriteLN('                "__STATE" => $__STATE')
            oObj:WriteLN('            ];')
            //IF .NOT. lDetail Select
                FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
                    IF oSelect:getIsFK()
                        oObj:WriteLN('            $dados["select_' + oCfg:getTableFrm() + '_' + oSelect:getName() + '"] = fk( "' + ;
                            oCfg:getTableFrm() + '","' + oSelect:getName() + '");' )
                    
                    ENDIF    
                NEXT
            //ENDIF    
            oObj:WriteLN('            $dados["__LOGIN"] = $session->get("login");')    
            oObj:WriteLN('            $dados["default"] = $this->default(); // Veja método anterior')    
            IF lDetail
                oObj:WriteLN('                $json=status_decode($__STATE); // Campo é hidden (Master-Detail)')
                oObj:WriteLN('                $dados["__DETAIL"] = $json["where"]["detail-fieldvalue"]; // Campo é hidden (Master-Detail)')            
            ENDIF    
            oObj:WriteLN('            echo view("templates/header_frm", $dados);')
            oObj:WriteLN('            echo view("'+ oCfg:getViewNameForm() +'", $dados);')
            oObj:WriteLN('            echo view("templates/footer", $dados);')
            oObj:WriteLN('          } else {')
            oObj:WriteLN('          } ')
            oObj:WriteLN('')
            oObj:WriteLN('    }')
            oObj:EndBlock()
        ENDIF 

        IF lGeraAlt
        
            oObj:IniBlock( "formaltera")
            oObj:WriteLN('    public function formaltera( $page = 1 , $pk = "" ,  $__STATE = "" )')
            oObj:WriteLN('    {')
            oObj:WriteLN('        $session = \Config\Services::session();')    
            oObj:WriteLN('        if (!$session->get("login"))')
            oObj:WriteLN('             return redirect()->to( "authentic/" );')
            oObj:WriteLN('        if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
            oObj:WriteLN('             return redirect()->to( "authentic/acessonegado" );')      
            oObj:WriteLN('        if (!$this->validate([])) {')
            oObj:WriteLN('            helper("form");')
            oObj:WriteLN('            $formData = form("'+ oCfg:getViewNameForm() +'_consulta.prg", $pk );')
            oObj:WriteLN('            $dados = [')
            oObj:WriteLN('                "oper" => "A",')
            oObj:WriteLN('                "titulo" => "Alteração",')
            oObj:WriteLN('                "form" => $formData,')
            oObj:WriteLN('                "__PK" => $pk,')
            oObj:WriteLN('                "__PAGE" => $page,')
            oObj:WriteLN('                "__STATE" => $__STATE')
            oObj:WriteLN('            ];')
            //IF .NOT. lDetail // Select
                FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
                    IF oSelect:getIsFK()
                        oObj:WriteLN('            $dados["select_' + oCfg:getTableFrm() + '_' + oSelect:getName() + '"] = fk( "' + ;
                            oCfg:getTableFrm() + '","' + oSelect:getName() + '");' )
                    
                    ENDIF    
                NEXT
            //ENDIF
            oObj:WriteLN('            $dados["__LOGIN"] = $session->get("login");')        
            IF lDetail
                oObj:WriteLN('                $json=status_decode($__STATE); // Campo é hidden (Master-Detail)')
                oObj:WriteLN('                $dados["__DETAIL"] = $json["where"]["detail-fieldvalue"]; // Campo é hidden (Master-Detail)')            
            ENDIF    
            oObj:WriteLN('            echo view("templates/header_frm", $dados);')
            oObj:WriteLN('            echo view("' + oCfg:getViewNameForm() + '", $dados);')
            oObj:WriteLN('            echo view("templates/footer", $dados);')
            oObj:WriteLN('          } else {')
            oObj:WriteLN('          } ')
            oObj:WriteLN('')
            oObj:WriteLN('    }')
            oObj:EndBlock()
        ENDIF    
    ENDIF 
    
    IF lGeraDelete .AND. lGeraGrid
        oObj:IniBlock( "exclui")
        oObj:WriteLN('    public function exclui( $page = 1 , $__PK = "" , $__STATE = "")')
        oObj:WriteLN('    {')
        oObj:WriteLN('        $session = \Config\Services::session();')    
        oObj:WriteLN('        if (!$session->get("login"))')
        oObj:WriteLN('             return redirect()->to( "authentic/" );')
        oObj:WriteLN('        if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
        oObj:WriteLN('             return redirect()->to( "authentic/acessonegado" );')      
        oObj:WriteLN('        $linha = "' + oCfg:getTableBrw() + '_exclui.prg ";')
        oObj:WriteLN('        $linha .= " --json --table ' +oCfg:getTableBrw() + ' --pkvalue $__PK";' )
        oObj:WriteLN("//echo $linha;" )
        oObj:WriteLN( '//return;')
        oObj:WriteLN('        $retorno = run( $linha );')
        oObj:WriteLN('        if ( $retorno["Result"] == "OK" )')
        oObj:WriteLN('            return redirect()->to( "' + oCfg:getViewNameGrid() + '/lista/$page/$__STATE" );')
        oObj:WriteLN('        else {')
        oObj:WriteLN('            $dados[ "titulo" ] = "Erro enviado pelo banco de dados";')
        oObj:WriteLN('            $dados[ "mensagem" ] = $retorno["Content"];')
        oObj:WriteLN(e"            $dados[ \"retorno\" ] = \"javascript:history.back()\";" ) // $_SERVER['HTTP_REFERER'];")
        oObj:WriteLN('            echo view("templates/erro", $dados);')
        oObj:WriteLN('            return;')        
        oObj:WriteLN('        }')      
        oObj:WriteLN('    }')
        oObj:EndBlock()    
    ENDIF    

    IF lGeraForm
        oObj:IniBlock( "grava")
        oObj:WriteLN('    public function grava()')
        oObj:WriteLN('    {')
        oObj:WriteLN('        $session = \Config\Services::session();')    
        oObj:WriteLN('        if (!$session->get("login"))')
        oObj:WriteLN('             return redirect()->to( "authentic/" );')
        oObj:WriteLN('        if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
        oObj:WriteLN('             return redirect()->to( "authentic/acessonegado" );')      
        oObj:WriteLN('        $posts = $this->request->getPost();')
        oObj:WriteLN('        $__PAGE = $this->request->getPost("__PAGE");')
        oObj:WriteLN('        $__PK = $this->request->getPost("__PK");')
        oObj:WriteLN('        $__STATE = $this->request->getPost("__STATE");')
        oObj:WriteLN('        // Libera posts')
        oObj:WriteLN('        unset($posts["__PAGE"]);')
        oObj:WriteLN('        unset($posts["__PK"]);')
        oObj:WriteLN('        unset($posts["__STATE"]);')
        FOR EACH cSelect IN oCfg:getFk()
            oObj:WriteLN('    $' + cSelect:__enumkey() + ' = addslashes( $this->request->getPost("' + cSelect:__enumkey() + '"));' )
        NEXT
        oObj:WriteLN('        $linha = "";')
        oObj:WriteLN('        if ( empty( $__PK ) )')
        oObj:WriteLN('            $linha .= "' + oCfg:getViewNameForm() + '_inclui.prg --json ";')
        oObj:WriteLN('        else')
        oObj:WriteLN('            $linha .= "' + oCfg:getViewNameForm() + '_altera.prg --json --pkvalue \"" . $__PK . "\" ";')
        oObj:WriteLN('        foreach ( $posts as $key => $elem )')
        oObj:WriteLN('        {')
        oObj:WriteLN('             if ( !empty( $__PK ) )')
        oObj:WriteLN('                 $elem = empty( $elem ) ? " " : $elem;')
        oObj:WriteLN(e"            $linha .= \"--\" . strtolower( $key ) . '  \"' . $elem . '\" ';")
        oObj:WriteLN('        }')
        oObj:WriteLN('        $retorno = run( $linha );')
        oObj:WriteLN('        if ( $retorno["Result"] == "OK" )')
        oObj:WriteLN('            return redirect()->to( "' +oCfg:getViewNameGrid() + '/lista/$__PAGE/$__STATE" );')
        oObj:WriteLN('        else {')
        oObj:WriteLN('            $dados[ "titulo" ] = "Erro enviado pelo banco de dados";')
        oObj:WriteLN('            $dados[ "mensagem" ] = $retorno["Content"];')
        oObj:WriteLN(e"            $dados[ \"retorno\" ] = \"javascript:history.back()\";" ) // $_SERVER['HTTP_REFERER'];")
        oObj:WriteLN('            echo view("templates/erro", $dados);')
        oObj:WriteLN('            return;')        
        oObj:WriteLN('        }')    
        oObj:WriteLN('    }')
        oObj:EndBlock() 
    ENDIF

    oObj:IniBlock( "reservado")
    oObj:WriteLN('    /**')
    oObj:WriteLN('    public function seuMetodo( $page = 1 , $__STATE = "")')
    oObj:WriteLN('    {')
    oObj:WriteLN('        //$session = \Config\Services::session();')
    oObj:WriteLN('        //if (!$session->get("login"))')
    oObj:WriteLN('        //     return redirect()->to( "authentic/" );')
    oObj:WriteLN('        //if ( !checkGrupo( "adm" , $session->get("grupo") ) )')
    oObj:WriteLN('        //     return redirect()->to( "authentic/acessonegado" );')      
    oObj:WriteLN('    }')
    oObj:WriteLN('    */')    
    oObj:EndBlock()        

    oObj:IniBlock( "fecha_classe")
    oObj:WriteLN("}")   
    oObj:EndBlock()        
#ifndef __PLATFORM__WINDOWS
    RUN ( "chmod 766 "  +  oCfg:getControllerNameFile() )
#endif
    ? " / Ok" 

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // PHP
    // View (Lista)
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    IF lGeraGrid
        ?? "Gerando ", oCfg:getViewNameGridFile()
        oObj := VCodeHtml():New( oCfg:getViewNameGridFile()  )
            
        //
        oObj:WriteLN(e"")
        oObj:WriteLN(e"")

        oObj:WriteLN(e"<div class=\"container mt-5\">")    

        oObj:IniBlock( "titulo")
        oObj:WriteLN("<h1>"+ oCfg:getBrwCaption() +"</h1>")
        oObj:EndBlock()       

        IF .NOT. lDetail
            oObj:IniBlock( "filtro")
            oObj:WriteLN("")
            oObj:WriteLN('<form method=get action="/' + oCfg:getViewNameGrid() + '/lista/<?=$__PAGE?>/" class="card p-3 bg-light">')
            oObj:WriteLN('<fieldset><legend>Filtros</legend>')
            FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
                IF chkFkField( oCfg:getTableBrw() , oCfg:getPKNameFromTable( oSelect:getTable()  ) , oCfg) 
                    IF .NOT. ( oSelect:getTable() == oCfg:getTableBrw() ) //.and. .NOT. EMPTY( oCfg:getPKNameFromTable( oSelect:getTable()  ))
                        
                        oObj:WriteLN('<div class="form-group">')            
                        oObj:WriteLN('   <label>'+oSelect:getCaption()+'</label>')
                        oObj:WriteLN('  <select class="form-select  mt-2" name="fk_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + '">')
                        oObj:WriteLN('  <?php')
                        oObj:WriteLN('      foreach ( $select_' + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + ' as $value ){')
                        oObj:WriteLN(e"        if ( $" + oCfg:getTableBrw() + '_' + oCfg:getPKNameFromTable( oSelect:getTable()  ) + e" == array_key_first($value) )")
                        oObj:WriteLN(e"            echo '<option selected=\"selected\" value=\"' . array_key_first($value) . '\">' . $value[ array_key_first($value) ] . '</option>';")
                        oObj:WriteLN(e"        else")
                        oObj:WriteLN(e"            echo '<option value=\"' . array_key_first($value) . '\">' . $value[ array_key_first($value) ] . '</option>';")
                        oObj:WriteLN("  }?>")
                        oObj:WriteLN('  </select>')
                        oObj:WriteLN('</div>')  
                    ENDIF
                ENDIF     
            NEXT
            
            IF .NOT. EMPTY( Vlj_ConfigJson2Value( "config.json" , {"brw","brw_"+hParams["--sufix"],"--where"} , "" ))
                oObj:WriteLN('<div class="form-group">')
                oObj:WriteLN('   <label>Termo ou Descrição</label>')
                oObj:WriteLN('   <input name="wdescricao" value="<?=$wdescricao?>" class="form-control  mt-2 form-control-dark w-100" type="text" placeholder="Digite os dados da busca" aria-label="Search">')
                oObj:WriteLN('</div>')    
            ENDIF    

        

            oObj:WriteLN('<div class="form-group d-grid gap-2 d-md-flex justify-content-md-end col-md-12">')
            oObj:WriteLN('<button type="submit" class="btn btn-primary mt-2">Grid</button>')
            oObj:WriteLN('<button type="submit" class="btn btn-primary mt-2" formaction="/' + oCfg:getViewNameGrid() + '/rpt">PDF</button>')
            oObj:WriteLN('</div>')    
            oObj:WriteLN('</fieldset>')
            oObj:WriteLN('</form>')
            oObj:EndBlock()       
        ENDIF    

        oObj:IniBlock( "tabela_inicio")
        oObj:WriteLN(e"    <table class=\"table tabled-striped table-bordered table-hover\">")
        oObj:WriteLN(e"    <thead> ")
        oObj:WriteLN(e"        <tr>")
        IF lGeraForm .and. lGeraInc
            oObj:WriteLN(e"           <td colspan="+hb_StrFormat("%d",oCfg:getNumberOfColumnsBrw()+1)+e"><a class=\"btn btn-primary\" href=\"/" + oCfg:getViewNameGrid() + e"/forminclui/<?php echo $__PAGE  . \"/\" . $__STATE;?>\" role=\"button\">Incluir</a></td>")
        ENDIF    
        IF lDetail
            oObj:WriteLN( '           <td><a class="btn btn-primary" href="javascript:window.close()" role="button">Fechar</a></td>')
        ENDIF    
        
        oObj:WriteLN(e"        </tr>")
        oObj:WriteLN(e"        <tr>")
        FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
            IF .NOT. oSelect:getIsPK()
                oObj:WriteLN('            <th>' + oSelect:getCaption() + '</th>')
            ENDIF    
        NEXT
        oObj:WriteLN('            <th></th>')
        oObj:WriteLN('            <th></th>')
        oObj:WriteLN(e"        </tr>")
        oObj:WriteLN(e"    </thead>")    
        oObj:EndBlock()



        oObj:IniBlock( "tabela_corpo_ini")   
        oObj:WriteLN(e"    <tbody>")
        oObj:WriteLN(" <?php $x=0;?>  ")     
        oObj:WriteLN(e"    <?php foreach( $Content[\"Grid\"] as $linha): ?>")
        oObj:WriteLN('<?php')
        oObj:WriteLN('if ( ++$x/2 == intval($x/2) ){')
        oObj:WriteLN('    $color="table-default";')
        oObj:WriteLN('} else {')
        oObj:WriteLN('    $color="table-light";')
        oObj:WriteLN('}')
        oObj:WriteLN('?>')
        oObj:WriteLN(e"        <tr class=\"<?=$color?>\">")
        FOR EACH oSelect IN oCfg:getColViewBrwAsArray()
            IF .NOT. oSelect:getIsPK()
                cContent := '$linha["' + IIF( EMPTY( oSelect:getAlias() ) , oSelect:getName(), oSelect:getAlias() ) + '"]'
                IF oSelect:getType() == "D"
                    cContent := 'date("d/m/Y", strtotime( ' + cContent + ' ));'
                ELSE
                    cContent += ";"    
                ENDIF        
                oObj:WriteLN('           <td width="40%"><?php echo ' + cContent + '?></td>')
            ENDIF   
        NEXT
        oObj:EndBlock()

        oObj:IniBlock( "botao_grid_extra")
        oObj:WriteLN("")
        oObj:EndBlock()
        
        oObj:IniBlock( "tabela_corpo_fim")    
        IF lMaster
            /*
            cMasterField := GetMasterField( cMasterTable , cDetailTable )
            cDetailField := GetDetailField( cMasterTable , cDetailTable )
            cMasterView := aJson[x]["master"]
            cDetailView := aJson[x]["detail"]
            */

            cLinkItens := "/" + cDetailView + "/lista/1?md_" + cDetailTable + "_" + cDetailField + "=" + '<?=$linha["' + cMasterField + '"];?>'
            oObj:WriteLN(e"           <td width=\"10%\"><a class=\"btn btn-primary\" onclick=\"OpenPopUp('" + cLinkItens + e"')\" href=\"#\" role=\"button\">Ítens</a></td>")
        ENDIF    
        IF lGeraForm .and. lGeraAlt
            oObj:WriteLN(e"           <td width=\"10%\"><a class=\"btn btn-primary\" href=\"/" + oCfg:getViewNameGrid() + e"/formaltera/<?php echo $__PAGE?>/<?php echo $linha[\""+ oCfg:getPkName()+ e"\"] . \"/\" . $__STATE;?>\" role=\"button\">Alterar</a></td>")
        ENDIF    
        IF lGeraDelete
            oObj:WriteLN(e"           <td width=\"10%\"><a class=\"btn btn-danger\"  onclick=\"return confirm('Tem certeza que deseja excluir esse ítem ?');\" href=\"/" +oCfg:getViewNameGrid() + e"/exclui/<?php echo $__PAGE?>/<?php echo $linha[\""+oCfg:getPkName()+ e"\"] . \"/\" . $__STATE;?>\" role=\"button\">Excluir</a></td>")
        ENDIF    
        oObj:WriteLN(e"        </tr>")
        oObj:EndBlock()

        oObj:IniBlock( "tabela_corpo_fim_extra")
        oObj:WriteLN(e"<!-- </tr><tr class=\"<?=$color?>\"><td colspan=xyz></td></tr>-->")
        oObj:WriteLN(e"    <?php endforeach;?>")
        oObj:WriteLN(e"    </tbody>")
        oObj:EndBlock()

        IF lDetail
            oObj:WriteLN(e"</table>")                                                 
            oObj:WriteLN(e"</div>")  
        ELSE    
            oObj:IniBlock( "tabela_rodape")    
            oObj:WriteLN(e"    <tfoot>")
            oObj:WriteLN(e"        <tr>")    
            oObj:WriteLN(e"            <td>")    
            oObj:WriteLN(e"                <nav>")    
            oObj:WriteLN(e"                     <ul class=\"pagination justify-content-left\">")    
            oObj:WriteLN(e"                         <?php ")    
            oObj:WriteLN(e"                          if ( $Content[\"IsPreviousPage\"] ):")                        
            oObj:WriteLN(e"                         ?>")                        
            oObj:WriteLN(e"                         <li class=\"page-item\">")                        
            oObj:WriteLN(e"                             <a class=\"page-link\" href=\"<?= base_url() ?>/" + oCfg:getViewNameGrid() + e"/lista/<?=( ( $__PAGE-1 ) . \"/\" . $__STATE )?>\" aria-label=\"Previous\">")                        
            oObj:WriteLN(e"                                 <span aria-hidden=\"true\">&laquo;</span>")                        
            oObj:WriteLN(e"                             </a>")                        
            oObj:WriteLN(e"                         </li>")                        
            oObj:WriteLN(e"                         <?php")                        
            oObj:WriteLN(e"                         endif;")                        
            oObj:WriteLN(e"                         ?>")                        
            oObj:WriteLN(e"                         <li>")                        
            oObj:WriteLN(e"                             <span aria-hidden=\"true\">")  
            oObj:WriteLN(e"                             <?php echo \"Página : $__PAGE\";    ?>")                        
            oObj:WriteLN(e"                             </span>")                        
            oObj:WriteLN(e"                         </li>")                                                    
            oObj:WriteLN(e"                         <?php")                        
            oObj:WriteLN(e"                         if ( $Content[\"IsNextPage\"] ):") 
            oObj:WriteLN(e"                         ?>") 
            oObj:WriteLN(e"                         <li class=\"page-item\">")             
            oObj:WriteLN(e"                             <a class=\"page-link\" href=\"<?= base_url() ?>/" + oCfg:getViewNameGrid() + e"/lista/<?=(  ($__PAGE+1) . \"/\" . $__STATE )?>\" aria-label=\"Next\">")     
            oObj:WriteLN(e"                                 <span aria-hidden=\"true\">&raquo;</span>")     
            oObj:WriteLN(e"                             </a>")     
            oObj:WriteLN(e"                         </li>")   
            oObj:WriteLN(e"                         <?php")         
            oObj:WriteLN(e"                         endif;")     
            oObj:WriteLN(e"                         ?>")     
            oObj:WriteLN(e"                     </ul>")                         
            oObj:WriteLN(e"                 </nav>")                         
            oObj:WriteLN(e"              </td>")   
            oObj:WriteLN(e"              <td colspan="+hb_StrFormat("%d",oCfg:getNumberOfColumnsBrw()+2)+e"></td>")                      
            oObj:WriteLN(e"        </tr>")                         
            oObj:WriteLN(e"   </tfoot>")                         
            oObj:WriteLN(e"</table>")                                                 
            oObj:WriteLN(e"</div>")  
            oObj:EndBlock()
            oObj:WriteLN(e"")          
        ENDIF    

        IF lMaster
            oObj:IniBlock( "javascript")
            oObj:WriteLN( "<script>function OpenPopUp( url ) { var win; win = window.open( url , 'Window', 'menubar=0, location=0 ,toolbar=0, resizable=1 ,status=0, scrollbars=1');if (win.document) {win.document.title = 'Ítens';}}</script>" )
            oObj:EndBlock()
        ENDIF    
        
        oObj:IniBlock( "personalizado")   
        oObj:EndBlock()
        oObj:WriteLN(e"")   
#ifndef __PLATFORM__WINDOWS       
        RUN ( "chmod 766 "  +  oCfg:getViewNameGridFile()  )
#endif
        ? " / Ok"
    ENDIF // lGeraGrid

  
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // PHP
    // View (Formulário)
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    IF lGeraForm .and. (lGeraAlt .or. lGeraInc)
        ?? "Gerando ", oCfg:getViewNameFormFile()
        oObj := VCodeHtml():New(  oCfg:getViewNameFormFile() )

        oObj:IniBlock( "form_cab")   
        oObj:WriteLN("<?php")
        oObj:WriteLN("if (isset($form)){")
        oObj:WriteLN("    $modo='ALTERACAO';")
        FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
            oObj:WriteLN('    $' + (oSelect:getName()) + ' = $form["Content"]["' + (oSelect:getName()) + '"];' )
        NEXT
        oObj:WriteLN("} else {")
        oObj:WriteLN("    $modo='INCLUSAO';")
        oObj:WriteLN(e"    $__PK = \"\";")
        FOR EACH oSelect IN oCfg:getColViewFrmAsArray()
            oObj:WriteLN('    $' + (oSelect:getName()) + ' = $default["' + (oSelect:getName()) + '"];' )
        NEXT
        oObj:WriteLN("}")  
        oObj:WriteLN("?>")
        oObj:EndBlock()

        oObj:IniBlock( "form_titulo")   
        oObj:WriteLN(e"<div class=\"container mt-5\">")
        oObj:WriteLN(" <center> <h1>"+ oCfg:getFrmCaption() +"</h1> </center>")
        oObj:EndBlock()
    
        oObj:IniBlock( "form_ini")   
        oObj:WriteLN('<?php echo form_open( "/' + oCfg:getViewNameGrid() + '/grava" , array( "name" => "' + oCfg:getViewNameGrid() + '", "class" => "form-group" , "class" => "row g-3" , "class" => "card p-3 bg-light" ) ); ?>' )
        oObj:WriteLN (e"<input type=\"hidden\" class=\"form-control\" name=\"__PK\" value=\"<?=$__PK?>\">")
        oObj:WriteLN( e"<input type=\"hidden\" class=\"form-control\" name=\"__PAGE\" value=\"<?=$__PAGE?>\"> ")
        oObj:WriteLN( e"<input type=\"hidden\" class=\"form-control\" name=\"__STATE\" value=\"<?=$__STATE?>\"> ")
        oObj:WriteLN( '<?php if ( $modo=="INCLUSAO" ){' )
        aJson := Vlj_ConfigJson2Value( "config.json" , {"frm","frm_" + hParams["--sufix"],"exclude-field","inc"} , {} )
        oObj:WriteLN( '     $a_except='+hb_jsonEncode(aJson)+';' )
        oObj:WriteLN( '} else {' )
        aJson := Vlj_ConfigJson2Value( "config.json" , {"frm","frm_" + hParams["--sufix"],"exclude-field","alt"} , {} )
        oObj:WriteLN( '     $a_except='+hb_jsonEncode(aJson)+';' )
        oObj:WriteLN( '}?>' )
        oObj:EndBlock()

        FOR EACH oSelect IN oCfg:getColViewFrmAsArray()

            
            oObj:IniBlock( "form_field_" + oSelect:getName())   
            oObj:WriteLN('<?php if ( !in_array( "'+oSelect:getName()+'",$a_except) ):?>')
            oObj:WriteLN('    <div class="row">')
            oObj:WriteLN('    <div class="col-md-3"></div>')

            oObj:WriteLN('    <div class="form-group col-md-6">')
            cRequired := IIF( oSelect:getIsNotNull() , " required " , " " )
            IF oSelect:getIsFK() 
                IF lDetail .AND. oSelect:getName() == cDetailField
                    oObj:WriteLN( e"    <input type=\"hidden\" class=\"form-control\" name=\"" + oSelect:getName() + e"\" value=\"<?=$__DETAIL?>\"> ")        
                ELSE    
                    oObj:WriteLN(e"      <label class=\"mt-2\" for=\"" + oSelect:getName() + e"\">" + oSelect:getCaption() + e"</label>")
                    oObj:WriteLN('      <select class="form-select" name="' + oSelect:getName()+'"'+cRequired+'>')
                    oObj:WriteLN('  <?php')
                    oObj:WriteLN('      foreach ( $select_' + oCfg:getTableFrm() + '_' + oSelect:getName() + ' as $value ){')
                    oObj:WriteLN(e"        if ( $modo=='ALTERACAO' && $" +  oSelect:getName() + e" == array_key_first($value) )")
                    oObj:WriteLN(e"            echo '    <option selected=\"selected\" value=\"' . array_key_first($value) . '\">' . $value[ array_key_first($value) ] . '</option>';")
                    oObj:WriteLN(e"         else")
                    oObj:WriteLN(e"            echo '    <option value=\"' . array_key_first($value) . '\">' . $value[ array_key_first($value) ] . '</option>';")
                    oObj:WriteLN("  }?>")
                    oObj:WriteLN('      </select>')
                ENDIF
            ELSE    
                IF oSelect:getIsPK()
                ELSE    
                    
                    DO CASE
                    CASE oSelect:getType() == "D"
                        oObj:WriteLN(e"      <label class=\"mt-2\" for=\"" + oSelect:getName() + e"\">" + oSelect:getCaption() + e"</label>")
                        oObj:WriteLN('      <input type="date" class="form-control mt-2" name="' + oSelect:getName() +'" placeholder="' + oSelect:getCaption() + '"  value="<?php echo isset($form) ? $form["Content"]["' + oSelect:getName() +'"] : $' + (oSelect:getName()) + ' ?>" '+cRequired+'>')
                    CASE oSelect:getType() == "M"
                        oObj:WriteLN(e"      <label class=\"mt-2\" for=\"" + oSelect:getName() + e"\">" + oSelect:getCaption() + e"</label>")
                        oObj:WriteLN('      <textarea class="form-control mt-2" name="' + oSelect:getName() +'" placeholder="' + oSelect:getCaption() + '"  rows="5" '+cRequired+'><?php echo isset($form) ? $form["Content"]["' + oSelect:getName() +'"] : $' + (oSelect:getName()) + ' ?></textarea>')
                    CASE oSelect:getType() == "L"
                        oObj:WriteLN('<?php')
                        oObj:WriteLN('  if ( isset($form) ) {')
                        oObj:WriteLN('      if ($form["Content"]["' + oSelect:getName() +'"]=="t"){')
                        oObj:WriteLN('          $checked="checked";')
                        oObj:WriteLN('      } else {')
                        oObj:WriteLN('          $checked="";')
                        oObj:WriteLN('      }')
                        oObj:WriteLN('  } else {')
                        oObj:WriteLN('      $checked="";')
                        oObj:WriteLN('  }')
                        oObj:WriteLN('?>')
                        oObj:WriteLN('    <div class="form-check">')
                        oObj:WriteLN('      <input type="checkbox" class="form-check-input mt-2" name="' + oSelect:getName() +'" placeholder="' + oSelect:getCaption() + '" <?php echo $checked?>>')
                        oObj:WriteLN(e"      <label class=\"form-check-label mt-2\" for=\"" + oSelect:getName() + e"\">" + oSelect:getCaption() + e"</label>")
                        oObj:WriteLN('    </div>')
                    OTHERWISE    
                        oObj:WriteLN(e"      <label class=\"mt-2\" for=\"" + oSelect:getName() + e"\">" + oSelect:getCaption() + e"</label>")
                        oObj:WriteLN('      <input type="text" class="form-control mt-2" name="' + oSelect:getName() +'" placeholder="' + oSelect:getCaption() + '"  value="<?php echo isset($form) ? $form["Content"]["' + oSelect:getName() +'"] : $' + (oSelect:getName()) + ' ?>" '+cRequired+'>')
                        
                    ENDCASE                    
                ENDIF
            ENDIF    
            oObj:WriteLN(e"    </div>")

            oObj:WriteLN('    <div class="col-md-3"></div>')
            oObj:WriteLN('    </div>')
            oObj:WriteLN('<?php endif?>')
            oObj:EndBlock()

        NEXT
        
        
        

        oObj:IniBlock( "form_botoes")   
        oObj:WriteLN('<div class="row">')
        oObj:WriteLN('<div class="col-md-3 mt-3"></div>')
        oObj:WriteLN('<div class="form-group col-md-6 mt-3">')
        oObj:WriteLN(e"<a href=\"/" + oCfg:getViewNameGrid()  + e"/lista/<?=$__PAGE?>/<?=$__STATE?>\" class=\"btn btn-primary\" role=\"button\">Retornar sem gravar</a>")
        oObj:WriteLN(e"<button type=\"submit\" class=\"btn btn-primary\">Gravar os dados</button>")
        oObj:WriteLN(e"</div>")
        oObj:WriteLN('<div class="col-md-3"></div>')
        oObj:WriteLN('</div>')
        oObj:EndBlock()

        oObj:IniBlock( "form_fim")   
        oObj:WriteLN('<div class="col-md-3"></div>')
        oObj:WriteLN(e"<?php echo form_close();?>")    
        oObj:WriteLN('</div>')
        oObj:EndBlock()

        oObj:IniBlock( "personalizado")   
        oObj:EndBlock()
#ifndef __PLATFORM__WINDOWS
        RUN ( "chmod 766 "  +  oCfg:getViewNameFormFile()  )
#endif
        ? " / Ok" 
        ? REPLICATE(".",50)
    

    ENDIF    // lGeraForm

 
    
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

STATIC FUNCTION GetDetailField( cMasterTable , cDetailTable )

    LOCAL cDetailField 
        /*
    Achar o campo fk na tabela detalhe (cDetailTable).
    Esse campo deve ser fk e a tabela onde a chave está deve ser a Master
    */
    cDetailField := ""
    USE dic_tables_col NEW SHARED
    dbSelectArea("dic_tables_col")
    SET FILTER TO cDetailTable == ALLTRIM(FIELD->TTABLE)
    GO TOP
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->FK) == "true"
            IF ALLTRIM(FIELD->TABLE_REF)==cMasterTable
                cDetailField := ALLTRIM(FIELD->TFIELD)
                EXIT
            ENDIF    
        ENDIF    
        SKIP
    ENDDO    
    CLOSE dic_tables_col
    IF EMPTY(cDetailField)
        SHELL ERROR  "GetDetailField: Não encontrei o campo FK na tabela detalhe a partir da tabela detalhe : " + cDetailTable
    ENDIF    

RETURN cDetailField            


STATIC FUNCTION GetMasterField( cMasterTable , cDetailTable )

    LOCAL cMasterField 
        /*
    Achar o campo fk na tabela detalhe (cMasterTable).
    Esse campo deve ser fk e a tabela onde a chave está deve ser a Master
    */
    cMasterField := ""
    USE dic_tables_col NEW SHARED
    dbSelectArea("dic_tables_col")
    SET FILTER TO cDetailTable == ALLTRIM(FIELD->TTABLE)
    GO TOP
    DO WHILE .NOT. EOF()
        IF ALLTRIM(FIELD->FK) == "true"
            IF ALLTRIM(FIELD->TABLE_REF)==cMasterTable
                cMasterField := ALLTRIM(FIELD->FIELD_REF)
                EXIT
            ENDIF    
        ENDIF    
        SKIP
    ENDDO    
    CLOSE dic_tables_col
    IF EMPTY(cMasterField)
        SHELL ERROR  "GetMasterField: Não encontrei o campo FK na tabela detalhe a partir da tabela mestre : " + cDetailTable
    ENDIF    

RETURN cMasterField    

STATIC FUNCTION chkFkField( cTable, cPkName , oCfg )
LOCAL lRet := .t.

IF EMPTY( cPkName)
    lRet := .f.
ENDIF

IF .not. ocfg:hasFieldInTableBrw(cPkName) 
    lRet := .f. 
ENDIF

RETURN lRet
