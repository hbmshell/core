#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
PROCEDURE Hbm_GenPHP( ... )
    MODULE SHELL
    
    LOCAL hParams , cPrintParams 
    LOCAL cSQL 
    LOCAL oObj
    LOCAL cPathCodeigniter := "../codeigniter/app"
    LOCAL cPkName 
    LOCAL hFieldFormView, cFieldView, hFK := {=>} , hFieldBrowseView
    LOCAL cNomeRot
    LOCAL cSelect
    LOCAL x
    LOCAL cNomeBrw, cNomeFrm
    

    SHELL ADD PARAM "--view" TITLE "Nome da view" MANDATORY REQUIRE VALUE // Obrigatório e deve informar um valor
    SHELL ADD PARAM "--igniter" TITLE "Path para a pasta app do codeigniter" REQUIRE VALUE 
    SHELL PRINT HELP TO cPrintParams

    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF

    SHELL GET PARAMS TO hParams 
    hb_HGetDef( hParams , "--igniter" , cPathCodeigniter ) 

    USE dic_views_col SHARED NEW
    USE dic_tables_col NEW SHARED
    USE dic_views NEW SHARED
    LOCATE FOR ALLTRIM( dic_views->VIEWNAME ) == hParams["--view"]
    cNomeBrw := ALLTRIM( dic_views->CAPTION )
    IF FOUND()
    ELSE
        SHELL ERROR "View " + hParams["--view"] + " não encontrada no dicionário" ERRORCODE 100
    ENDIF    
    IF EMPTY(MetaPKName( dic_views->TTABLE_BRW ))
        SHELL ERROR "View " + hParams["--view"] + " não possui referência a uma chave primária" ERRORCODE 101
    ENDIF
    hFieldFormView := MetaFieldViewListCaptions( "frm_" + Substr( hParams["--view"] , 5 ) , @hFK )    
    hFieldBrowseView := MetaFieldViewListCaptions( hParams["--view"] )     
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // PHP
    // Controller
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    cNomeRot := cPathCodeigniter + hb_ps() + "Controllers" + hb_ps() + TokenUpper( hParams["--view"] ) + ".php"
    oObj := VCodePhp():New( cNomeRot )
    oObj:WriteLN("<?php")
    oObj:WriteLN("namespace App\Controllers;")
    oObj:WriteLN("class " + TokenUpper( hParams["--view"] ) + " extends BaseController")
    oObj:WriteLN("{")
    oObj:WriteLN("")
    oObj:IniBlock( "lista")
    oObj:WriteLN('    public function lista( $page = 1 , $ENDERECO_IP = "" , $DE = "" )')
    oObj:WriteLN('    {')
    oObj:WriteLN('        helper("form");')
    oObj:WriteLN('        if ( !empty( $this->request->getPost() ) ){')
    oObj:WriteLN('        }')
    oObj:WriteLN('        $dados = grid("'+hParams["--view"]+'.prg" , $page );')
    oObj:WriteLN('        $dados["titulo"] = "Listagem de Endereços IP";')
    oObj:WriteLN('        $dados["__PAGE"] = $page;')
    oObj:WriteLN('        $dados["__FILTER"] = [];')
    oObj:WriteLN('')
    oObj:WriteLN('        echo view("templates/header",$dados);')
    oObj:WriteLN('        echo view("' +  hParams["--view"] + '", $dados);')
    oObj:WriteLN('        echo view("templates/footer");')
    oObj:WriteLN('')
    oObj:WriteLN('    }')
    oObj:EndBlock()

    oObj:IniBlock( "forminclui")
    oObj:WriteLN('    public function forminclui( $page = 1 )')
    oObj:WriteLN('    {')
    oObj:WriteLN('        if (!$this->validate([])) {')
    oObj:WriteLN('            helper("form");')
    oObj:WriteLN('            $dados = [')
    oObj:WriteLN('                "oper" => "I",')
    oObj:WriteLN('                "titulo" => "Inclusão",')
    oObj:WriteLN('                "__PAGE" => $page,')
    oObj:WriteLN('                $dados["__FILTER"] = []')
    oObj:WriteLN('            ];')
    FOR EACH cSelect IN hFk
        oObj:WriteLN('            $dados["select_' + cSelect + '_' + cSelect:__enumkey() + '"] = fk( "' + ;
        cSelect + '","' + LOWER(cSelect:__enumkey()) + '");' )
    NEXT
    oObj:WriteLN('            echo view("templates/header", $dados);')
    oObj:WriteLN('            echo view("'+"frm_" + Substr( hParams["--view"] , 5 ) +'", $dados);')
    oObj:WriteLN('            echo view("templates/footer", $dados);')
    oObj:WriteLN('          } else {')
    oObj:WriteLN('          } ')
    oObj:WriteLN('')
    oObj:WriteLN('    }')
    oObj:EndBlock()

    oObj:IniBlock( "formaltera")
    oObj:WriteLN('    public function formaltera( $page = 1 , $pk )')
    oObj:WriteLN('    {')
    oObj:WriteLN('        if (!$this->validate([])) {')
    oObj:WriteLN('            helper("form");')
    oObj:WriteLN('            $formData = form("frm_'+ Substr( hParams["--view"] , 5 ) +'_consulta.prg", $pk );')
    oObj:WriteLN('            $dados = [')
    oObj:WriteLN('                "oper" => "A",')
    oObj:WriteLN('                "titulo" => "Alteração",')
    oObj:WriteLN('                "form" => $formData,')
    oObj:WriteLN('                "__PK" => $pk,')
    oObj:WriteLN('                "__PAGE" => $page,')
    oObj:WriteLN('                $dados["__FILTER"] = []')
    oObj:WriteLN('            ];')
    FOR EACH cSelect IN hFk
        oObj:WriteLN('            $dados["select_' + cSelect + '_' + cSelect:__enumkey() + '"] = fk( "' + ;
                                    cSelect + '","' + LOWER(cSelect:__enumkey()) + '");' )
    NEXT
    oObj:WriteLN('            echo view("templates/header", $dados);')
    oObj:WriteLN('            echo view("'+"frm_" + Substr( hParams["--view"] , 5 ) +'", $dados);')
    oObj:WriteLN('            echo view("templates/footer", $dados);')
    oObj:WriteLN('          } else {')
    oObj:WriteLN('          } ')
    oObj:WriteLN('')
    oObj:WriteLN('    }')
    oObj:EndBlock()
    
    oObj:IniBlock( "exclui")
    oObj:WriteLN('    public function exclui( $page = 1 , $pk = "" )')
    oObj:WriteLN('    {')
    oObj:WriteLN('        $linha = "' + MetaTableNameByViewName(  hParams["--view"] ) + '_exclui.prg ";')
    oObj:WriteLN('        $linha .= " --json --table ' + MetaTableNameByViewName(  hParams["--view"] ) + ' --pkvalue $pk";' )
    oObj:WriteLN("//echo $linha;" )
    oObj:WriteLN( '//return;')
    oObj:WriteLN('        $retorno = run( $linha );')
    oObj:WriteLN('        if ( $retorno["Result"] == "OK" )')
    oObj:WriteLN('            return redirect()->to( "' + hParams["--view"] + '/lista/$page" );')
    oObj:WriteLN('        else {')
    oObj:WriteLN('            $dados[ "titulo" ] = "Erro enviado pelo banco de dados";')
    oObj:WriteLN('            $dados[ "mensagem" ] = $retorno["Content"];')
    oObj:WriteLN(e"            $dados[ \"retorno\" ] = \"javascript:history.back()\";" ) // $_SERVER['HTTP_REFERER'];")
    oObj:WriteLN('            echo view("templates/erro", $dados);')
    oObj:WriteLN('            return;')        
    oObj:WriteLN('        }')      
    oObj:WriteLN('    }')
    oObj:EndBlock()

    oObj:IniBlock( "grava")
    oObj:WriteLN('    public function grava()')
    oObj:WriteLN('    {')
    oObj:WriteLN('        $posts = $this->request->getPost();')
    oObj:WriteLN('        $__PAGE = $this->request->getPost("__PAGE");')
    oObj:WriteLN('        $__PK = $this->request->getPost("__PK");')
    oObj:WriteLN('        // Libera posts')
    oObj:WriteLN('        unset($posts["__PAGE"]);')
    oObj:WriteLN('        unset($posts["__PK"]);')
    FOR EACH cFieldView IN hFieldFormView
        oObj:WriteLN('    $' + cFieldView:__enumkey() + ' = addslashes( $this->request->getPost("' + cFieldView:__enumkey() + '"));' )
    NEXT
    oObj:WriteLN('        $linha = "";')
    oObj:WriteLN('        if ( empty( $__PK ) )')
    oObj:WriteLN('            $linha .= "' + "frm_" + Substr( hParams["--view"] , 5 ) + '_inclui.prg --json ";')
    oObj:WriteLN('        else')
    oObj:WriteLN('            $linha .= "frm_' + Substr( hParams["--view"] , 5 ) + '_altera.prg --json --pkvalue \"" . $__PK . "\" ";')
    oObj:WriteLN('        foreach ( $posts as $key => $elem )')
    oObj:WriteLN('        {')
    oObj:WriteLN(e"            $linha .= \"--\" . strtolower( $key ) . '  \"' . $elem . '\" ';")
    oObj:WriteLN('        }')
    oObj:WriteLN('        $retorno = run( $linha );')
    oObj:WriteLN('        if ( $retorno["Result"] == "OK" )')
    oObj:WriteLN('            return redirect()->to( "' + hParams["--view"] + '/lista/$__PAGE" );')
    oObj:WriteLN('        else {')
    oObj:WriteLN('            $dados[ "titulo" ] = "Erro enviado pelo banco de dados";')
    oObj:WriteLN('            $dados[ "mensagem" ] = $retorno["Content"];')
    oObj:WriteLN(e"            $dados[ \"retorno\" ] = \"javascript:history.back()\";" ) // $_SERVER['HTTP_REFERER'];")
    oObj:WriteLN('            echo view("templates/erro", $dados);')
    oObj:WriteLN('            return;')        
    oObj:WriteLN('        }')    
    oObj:WriteLN('    }')
    oObj:WriteLN("}")   
    oObj:EndBlock() 

    RUN ( "chmod 766 "  +  cNomeRot )

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // PHP
    // View (Lista)
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    cNomeRot := cPathCodeigniter + hb_ps() + "Views" + hb_ps() + hParams["--view"] + ".php"
    oObj := VCodeHtml():New( cNomeRot  )
        
    oObj:WriteLN("<?php")
    oObj:WriteLN(e"if ( !empty( $__FILTER[\"ENDERECO_IP\"] ) || !empty( $__FILTER[\"DE\"]  ) )")
    oObj:WriteLN(e"     $COMPLEMENTO_FILTRO = \"/\" . $__FILTER[\"ENDERECO_IP\"] . \"/\" . $__FILTER[\"DE\"];")
    oObj:WriteLN("else")        
    oObj:WriteLN(e"     $COMPLEMENTO_FILTRO = \"\";")
    oObj:WriteLN("?>")
    
    //oObj:WriteLN(e"<div class=\"container mt-5\">")


    // Formulário de busca
    /*
    oObj:WriteLN(e"<?php echo form_open( \"/" + hParams["--view"] + e"/lista/\" ,  array('class' => 'row' ) ); ?>")
    oObj:WriteLN(e"   <div class=\"col\">")
    oObj:WriteLN(e"      <input type=\"text\" class=\"form-control\" name=\"DE\" value=\"<?=$__FILTER[\"DE\"]?>\" placeholder=\"Descrição\">")
    oObj:WriteLN("   </div>")
    oObj:WriteLN(e"   <div class=\"col\">")
    oObj:WriteLN(e"     <button type=\"submit\" class=\"btn btn-primary\">Filtrar</button>")
    oObj:WriteLN("   </div>")
    oObj:WriteLN("</div>")
    oObj:WriteLN("</form>")
    */
    //
    oObj:WriteLN(e"")
    oObj:WriteLN(e"")

    oObj:WriteLN(e"<div class=\"container mt-5\">")    
    oObj:WriteLN("<h1>"+ cNomeBrw +"</h1>")
    oObj:WriteLN(e"    <table class=\"table tabled-striped table-bordered table-hover\">")
    oObj:WriteLN(e"    <thead> ")
    oObj:WriteLN(e"        <tr>")
    oObj:WriteLN(e"           <td colspan="+hb_StrFormat("%d",Len(hFieldBrowseView)+2)+e"><a class=\"btn btn-primary\" href=\"/" + hParams["--view"] + e"/forminclui/<?php echo $__PAGE?>\" role=\"button\">Incluir</a></td>")

    oObj:WriteLN(e"        </tr>")
    oObj:WriteLN(e"        <tr>")
    FOR EACH cFieldView IN hFieldBrowseView
        oObj:WriteLN('            <th>' + cFieldView + '</th>')
    NEXT
    oObj:WriteLN('            <th></th>')
    oObj:WriteLN('            <th></th>')

    oObj:WriteLN(e"        </tr>")
    oObj:WriteLN(e"    </thead>")
    oObj:WriteLN(e"    <tbody>")
    oObj:WriteLN(e"    <?php foreach( $Content[\"Grid\"] as $linha): ?>")
    oObj:WriteLN(e"        <tr>")
    FOR EACH cFieldView IN hFieldBrowseView
        oObj:WriteLN('           <td width=\"40%\"><?php echo $linha["' + cFieldView:__enumkey() + '"];?></td>')
    NEXT

    
    oObj:WriteLN(e"           <td width=\"10%\"><a class=\"btn btn-primary\" href=\"/" + hParams["--view"] + e"/formaltera/<?php echo $__PAGE?>/<?php echo $linha[\""+MetaPKName( dic_views->TTABLE_BRW )+ e"\"] . $COMPLEMENTO_FILTRO;?>\" role=\"button\">Alterar</a></td>")
    oObj:WriteLN(e"           <td width=\"10%\"><a class=\"btn btn-danger\"  onclick=\"return confirm('Tem certeza que deseja excluir esse ítem ?');\" href=\"/" + hParams["--view"] + e"/exclui/<?php echo $__PAGE?>/<?php echo $linha[\""+MetaPKName( dic_views->TTABLE_BRW )+ e"\"] . $COMPLEMENTO_FILTRO;?>\" role=\"button\">Excluir</a></td>")
    oObj:WriteLN(e"        </tr>")
    oObj:WriteLN(e"    <?php endforeach;?>")
    oObj:WriteLN(e"    </tbody>")
    oObj:WriteLN(e"    <tfoot>")
    oObj:WriteLN(e"        <tr>")    
    oObj:WriteLN(e"            <td>")    
    oObj:WriteLN(e"                <nav>")    
    oObj:WriteLN(e"                     <ul class=\"pagination justify-content-left\">")    
    oObj:WriteLN(e"                         <?php ")    
    oObj:WriteLN(e"                          if ( $Content[\"IsPreviousPage\"] ):")                        
    oObj:WriteLN(e"                         ?>")                        
    oObj:WriteLN(e"                         <li class=\"page-item\">")                        
    oObj:WriteLN(e"                             <a class=\"page-link\" href=\"<?= base_url() ?>/" + hParams["--view"] + e"/lista/<?=( ( $__PAGE-1 ) . $COMPLEMENTO_FILTRO )?>\" aria-label=\"Previous\">")                        
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
    oObj:WriteLN(e"                             <a class=\"page-link\" href=\"<?= base_url() ?>/" + hParams["--view"] + e"/lista/<?=(  ($__PAGE+1) . $COMPLEMENTO_FILTRO )?>\" aria-label=\"Next\">")     
    oObj:WriteLN(e"                                 <span aria-hidden=\"true\">&raquo;</span>")     
    oObj:WriteLN(e"                             </a>")     
    oObj:WriteLN(e"                         </li>")   
    oObj:WriteLN(e"                         <?php")         
    oObj:WriteLN(e"                         endif;")     
    oObj:WriteLN(e"                         ?>")     
    oObj:WriteLN(e"                     </ul>")                         
    oObj:WriteLN(e"                 </nav>")                         
    oObj:WriteLN(e"              </td>")   
    oObj:WriteLN(e"              <td colspan="+hb_StrFormat("%d",Len(hFieldBrowseView)+2)+e"></td>")                      
    oObj:WriteLN(e"        </tr>")                         
    oObj:WriteLN(e"   </tfoot>")                         
    oObj:WriteLN(e"</table>")                                                 
    oObj:WriteLN(e"</div>")  

    oObj:WriteLN(e"")          
    RUN ( "chmod 766 "  +  cNomeRot  )


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // PHP
    // View (Formulário)
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    cNomeRot := cPathCodeigniter + hb_ps() + "Views" + hb_ps() + "frm_" + Substr( hParams["--view"] , 5 ) + ".php"
    oObj := VCodeHtml():New( cNomeRot  )

    
    oObj:WriteLN("<?php")
    oObj:WriteLN("if (isset($form)){")
    FOR EACH cFieldView IN hFieldFormView
        oObj:WriteLN('    $' + cFieldView:__enumkey() + ' = $form["Content"]["' + cFieldView:__enumkey() + '"];' )
    NEXT
    oObj:WriteLN("} else {")
    oObj:WriteLN(e"    $__PK = \"\";")
    oObj:WriteLN("}")  
    oObj:WriteLN("?>")
    oObj:WriteLN(e"<div class=\"container mt-5\">")

    LOCATE FOR ALLTRIM( dic_views->VIEWNAME ) == "frm_" + Substr( hParams["--view"] , 5 )
    cNomeFrm := ALLTRIM( dic_views->CAPTION )
    oObj:WriteLN(" <center> <h1>"+ cNomeFrm +"</h1> </center>")
    
    oObj:WriteLN('<?php echo form_open( "/' + hParams["--view"] + '/grava" , array( "name" => "' + alltrim(dic_views->VIEWNAME) + '", "class" => "form-group" , "class" => "row g-3")  ); ?>' )
    oObj:WriteLN (e"<input type=\"hidden\" class=\"form-control\" name=\"__PK\" value=\"<?=$__PK?>\">")
    oObj:WriteLN( e"<input type=\"hidden\" class=\"form-control\" name=\"__PAGE\" value=\"<?=$__PAGE?>\"> ")
    //<input type="hidden" class="form-control" name="__COMPLEMENTO_FILTRO" value="<?=$COMPLEMENTO_FILTRO?>">

    FOR EACH cFieldView IN hFieldFormView

        oObj:WriteLN('<div class="col-md-3"></div>')

        oObj:WriteLN('<div class="form-group col-md-6">')
        oObj:WriteLN(e"  <label for=\"" + cFieldView:__enumkey() + e"\">" + cFieldView + e"</label>")
        IF hb_HHasKey( hFK , cFieldView:__enumkey() )  
            oObj:WriteLN('  <select class="form-select" name="' + cFieldView:__enumkey()+'">')
            oObj:WriteLN('  <?php')
            oObj:WriteLN('      foreach ( $select_' + hFK[ cFieldView:__enumkey() ] + '_' + cFieldView:__enumkey() + ' as $value ){')
            oObj:WriteLN(e"        if ( $" +  cFieldView:__enumkey() + e" == array_key_first($value) )")
            oObj:WriteLN(e"            echo '<option selected=\"selected\" value=\"' . array_key_first($value) . '\">' . $value[ array_key_first($value) ] . '</option>';")
            oObj:WriteLN(e"         else")
            oObj:WriteLN(e"            echo '<option value=\"' . array_key_first($value) . '\">' . $value[ array_key_first($value) ] . '</option>';")
            oObj:WriteLN("  }?>")
            oObj:WriteLN('  </select>')
        ELSE    
            oObj:WriteLN('  <input type="text" class="form-control" name="' + cFieldView:__enumkey()+'" placeholder="' + cFieldView + '"  value="<?php echo isset($form) ? $form["Content"]["' + cFieldView:__enumkey()+'"] : "" ?>">')
        ENDIF    
        oObj:WriteLN(e"</div>")

        oObj:WriteLN('<div class="col-md-3"></div>')

    NEXT
    
    oObj:WriteLN('<div class="col-md-3"></div>')

    oObj:WriteLN('<div class="form-group col-md-6">')
    oObj:WriteLN(e"<a href=\"/" + hParams["--view"]  + e"/lista/<?=$__PAGE?>\" class=\"btn btn-primary\" role=\"button\">Retornar</a>")
    oObj:WriteLN(e"<button type=\"submit\" class=\"btn btn-primary\">Enviar</button>")
    oObj:WriteLN(e"</div>")

    oObj:WriteLN('<div class="col-md-3"></div>')

    oObj:WriteLN(e"<?php echo form_close();?>")    
    oObj:WriteLN('</div>')
    oObj:WriteLN('<script>document.' +  alltrim(dic_views->VIEWNAME) + '.' + HB_hKeyAt( hFieldFormView , 1 ) + '.focus();</script>')
    RUN ( "chmod 766 "  +  cNomeRot  )

 
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

FUNCTION MetaPKName( cTable )

LOCAL cPkName := ""
LOCAL cAliasOld := ALIAS()

    SELECT dic_tables_col
    cTable := ALLTRIM( cTable )
    DO WHILE .NOT. EOF()
        IF UPPER( ALLTRIM( FIELD->TTABLE )) == UPPER(cTable)
            IF ALLTRIM( FIELD->PK ) == "true" 
                cPkName := ALLTRIM( FIELD->TFIELD)
                EXIT
            ENDIF
        ENDIF    
        SKIP
    ENDDO    

    IF .NOT. EMPTY( cAliasOld )
        dbSelectArea( cAliasOld )
    ENDIF    

RETURN ALLTRIM( UPPER( cPkName ) )

FUNCTION MetaFieldViewListCaptions( cView , hFK )

    LOCAL hView := {=>}
    LOCAL cAliasOld := ALIAS()

    dic_views_col->(dbGoTop())
    hFK := {=>}
    DO WHILE .NOT. dic_views_col->( EOF() )
        IF ALLTRIM(dic_views_col->VIEWNAME) == cView
            IF .NOT. dic_views_col->IS_PK // Omite a chave primária
                hView[ ALLTRIM(UPPER(dic_views_col->TFIELD)) ] := ALLTRIM((dic_views_col->CAPTION)) 
            ENDIF    
            IF dic_views_col->IS_FK // Adiciona dados FK
                hFK[ ALLTRIM(UPPER(dic_views_col->TFIELD)) ] := ALLTRIM((dic_views_col->TTABLE)) 
            ENDIF    
        ENDIF
        dic_views_col->( dbSKIP() )
    ENDDO    

    IF .NOT. EMPTY( cAliasOld )
        dbSelectArea( cAliasOld )
    ENDIF    

RETURN hView

FUNCTION MetaTableNameByViewName( cView )

    LOCAL cTable := ""
    LOCAL cAliasOld := ALIAS()

    dic_views->(dbGoTop())
    DO WHILE .NOT. dic_views->( EOF() )
        IF ALLTRIM(dic_views->VIEWNAME) == cView
            cTable := ALLTRIM( dic_views->TTABLE_BRW )
            EXIT
        ENDIF
        dic_views->( dbSKIP() )
    ENDDO    

    IF .NOT. EMPTY( cAliasOld )
        dbSelectArea( cAliasOld )
    ENDIF    

RETURN cTable
