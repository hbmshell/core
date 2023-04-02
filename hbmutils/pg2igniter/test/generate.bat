REM  Esse script foi gerado automaticamente através do script gen_script.prg (juntamente com config.json)
@ECHO OFF
hbmshell.exe ..\generate\chkconfig.prg
IF %ERRORLEVEL% NEQ 0 EXIT /b 1
REM  Gerando listas/grid
hbmshell.exe ..\generate\gen_lista.prg  --view brw_patr_recolhe --orderby "patr.de"  --where "patr.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix patr_recolhe
hbmshell.exe ..\generate\gen_relat.prg   --view brw_patr_recolhe --orderby "patr_gr.de,local.de,patr.de"  --orientation "2"  --orderby "patr.de"  --where "patr.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_imp
hbmshell.exe ..\generate\gen_php.prg   --sufix imp
hbmshell.exe ..\generate\gen_relat.prg   --view brw_imp
hbmshell.exe ..\generate\gen_lista.prg  --view brw_grupfor --orderby "de"  --where "grupfor.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix grupfor
hbmshell.exe ..\generate\gen_relat.prg   --view brw_grupfor --orderby "de"  --where "grupfor.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_fornecedor --orderby "fornecedor.de"  --where "fornecedor.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix fornecedor
hbmshell.exe ..\generate\gen_relat.prg   --view brw_fornecedor --orderby "fornecedor.de"  --where "fornecedor.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_usuario --orderby "login"  --where "usuario.login ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix usuario
hbmshell.exe ..\generate\gen_relat.prg   --view brw_usuario --orderby "login"  --where "usuario.login ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_material --orderby "material.de"  --where "material.de ILIKE '%%' || '%%s' || '%%'  or material.obs ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix material
hbmshell.exe ..\generate\gen_relat.prg   --view brw_material --orderby "material.de"  --where "material.de ILIKE '%%' || '%%s' || '%%'  or material.obs ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_almox --orderby "de"  --where "almox.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix almox
hbmshell.exe ..\generate\gen_relat.prg   --view brw_almox --orderby "de"  --where "almox.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_tarefa --orderby "dat_ini"  --where "tarefa.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix tarefa
hbmshell.exe ..\generate\gen_relat.prg   --view brw_tarefa --orderby "dat_ini"  --where "tarefa.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_tarefa_item
hbmshell.exe ..\generate\gen_php.prg   --sufix tarefa_item
hbmshell.exe ..\generate\gen_relat.prg   --view brw_tarefa_item
hbmshell.exe ..\generate\gen_lista.prg  --view brw_material_transfer
hbmshell.exe ..\generate\gen_php.prg   --sufix material_transfer
hbmshell.exe ..\generate\gen_relat.prg   --view brw_material_transfer
hbmshell.exe ..\generate\gen_lista.prg  --view brw_setor --orderby "de"  --where "setor.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix setor
hbmshell.exe ..\generate\gen_relat.prg   --view brw_setor --orderby "de"  --where "setor.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_ip --orderby "endereco_ip"  --where "ip.de ILIKE '%%' || '%%s' || '%%'   or ip.endereco_ip ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix ip
hbmshell.exe ..\generate\gen_relat.prg   --view brw_ip --orderby "endereco_ip"  --where "ip.de ILIKE '%%' || '%%s' || '%%'   or ip.endereco_ip ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_local --orderby "local.de"  --where "local.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix local
hbmshell.exe ..\generate\gen_relat.prg   --view brw_local --orderby "local.de"  --where "local.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_patr_gr --orderby "de"  --where "patr_gr.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix patr_gr
hbmshell.exe ..\generate\gen_relat.prg   --view brw_patr_gr --orderby "de"  --where "patr_gr.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_prof --orderby "nome"  --where "prof.nome ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix prof
hbmshell.exe ..\generate\gen_relat.prg   --view brw_prof --orderby "nome"  --where "prof.nome ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_projeto --orderby "de"  --where "projeto.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix projeto
hbmshell.exe ..\generate\gen_relat.prg   --view brw_projeto --orderby "de"  --where "projeto.de ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_patr_recolhido --orderby "patr_recolhido.de"  --where "patr_recolhido.de ILIKE '%%' || '%%s' || '%%' or patr_recolhido.plaqueta_ufc ILIKE '%%' || '%%s' || '%%' or patr_recolhido.plaqueta_dc ILIKE '%%' || '%%s' || '%%' or patr_recolhido.plaqueta_fundacao ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_great ILIKE '%%' || '%%s' || '%%'  or patr_recolhido.obs ILIKE '%%' || '%%s' || '%%'"  --delete "off" 
hbmshell.exe ..\generate\gen_php.prg   --sufix patr_recolhido
hbmshell.exe ..\generate\gen_relat.prg   --view brw_patr_recolhido --orderby "patr_recolhido.de"  --where "patr_recolhido.de ILIKE '%%' || '%%s' || '%%' or patr_recolhido.plaqueta_ufc ILIKE '%%' || '%%s' || '%%' or patr_recolhido.plaqueta_dc ILIKE '%%' || '%%s' || '%%' or patr_recolhido.plaqueta_fundacao ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_great ILIKE '%%' || '%%s' || '%%'  or patr_recolhido.obs ILIKE '%%' || '%%s' || '%%'"  --delete "off" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_patr --orderby "de"  --where "patr.de ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_ufc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_dc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_fundacao ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_great ILIKE '%%' || '%%s' || '%%' or patr.obs ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix patr
hbmshell.exe ..\generate\gen_relat.prg   --view brw_patr --orderby "local.de,patr_gr.de,patr.de"  --orientation "1"  --orderby "de"  --where "patr.de ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_ufc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_dc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_fundacao ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_great ILIKE '%%' || '%%s' || '%%' or patr.obs ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_patr_emprestado --orderby "patr.de"  --where "patr.de ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_ufc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_dc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_fundacao ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_great ILIKE '%%' || '%%s' || '%%' or patr.obs ILIKE '%%' || '%%s' || '%%'"  --delete "off" 
hbmshell.exe ..\generate\gen_php.prg   --sufix patr_emprestado
hbmshell.exe ..\generate\gen_relat.prg   --view brw_patr_emprestado --orderby "local.de,patr_gr.de,patr.de"  --orientation "2"  --orderby "patr.de"  --where "patr.de ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_ufc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_dc ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_fundacao ILIKE '%%' || '%%s' || '%%' or patr.plaqueta_great ILIKE '%%' || '%%s' || '%%' or patr.obs ILIKE '%%' || '%%s' || '%%'"  --delete "off" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_digital --orderby "nome"  --where "digital.nome ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix digital
hbmshell.exe ..\generate\gen_relat.prg   --view brw_digital --orderby "nome"  --where "digital.nome ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_lista.prg  --view brw_faixa --orderby "prefixo"  --where "faixa.prefixo ILIKE '%%' || '%%s' || '%%'" 
hbmshell.exe ..\generate\gen_php.prg   --sufix faixa
hbmshell.exe ..\generate\gen_relat.prg   --view brw_faixa --orderby "prefixo"  --where "faixa.prefixo ILIKE '%%' || '%%s' || '%%'" 
REM # Gerando Forms isolados
hbmshell.exe ..\generate\gen_php.prg   --sufix tarefa_iniciar
REM  Gerando consulta, exclusão , inclusão e alteração
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_patr_recolhe
hbmshell.exe ..\generate\gen_altera.prg   --view frm_patr_recolhe
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_patr_recolhe
hbmshell.exe ..\generate\gen_exclui.prg   --table patr_recolhe
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_imp
hbmshell.exe ..\generate\gen_altera.prg   --view frm_imp
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_imp
hbmshell.exe ..\generate\gen_exclui.prg   --table imp
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_grupfor
hbmshell.exe ..\generate\gen_altera.prg   --view frm_grupfor
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_grupfor
hbmshell.exe ..\generate\gen_exclui.prg   --table grupfor
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_fornecedor
hbmshell.exe ..\generate\gen_altera.prg   --view frm_fornecedor
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_fornecedor
hbmshell.exe ..\generate\gen_exclui.prg   --table fornecedor
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_usuario
hbmshell.exe ..\generate\gen_altera.prg   --view frm_usuario
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_usuario
hbmshell.exe ..\generate\gen_exclui.prg   --table usuario
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_material
hbmshell.exe ..\generate\gen_altera.prg   --view frm_material
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_material
hbmshell.exe ..\generate\gen_exclui.prg   --table material
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_almox
hbmshell.exe ..\generate\gen_altera.prg   --view frm_almox
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_almox
hbmshell.exe ..\generate\gen_exclui.prg   --table almox
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_tarefa
hbmshell.exe ..\generate\gen_altera.prg   --view frm_tarefa
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_tarefa
hbmshell.exe ..\generate\gen_exclui.prg   --table tarefa
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_tarefa_iniciar
hbmshell.exe ..\generate\gen_altera.prg   --view frm_tarefa_iniciar
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_tarefa_iniciar
hbmshell.exe ..\generate\gen_exclui.prg   --table tarefa
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_tarefa_item
hbmshell.exe ..\generate\gen_altera.prg   --view frm_tarefa_item
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_tarefa_item
hbmshell.exe ..\generate\gen_exclui.prg   --table tarefa_item
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_material_transfer
hbmshell.exe ..\generate\gen_altera.prg   --view frm_material_transfer
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_material_transfer
hbmshell.exe ..\generate\gen_exclui.prg   --table material_transfer
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_setor
hbmshell.exe ..\generate\gen_altera.prg   --view frm_setor
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_setor
hbmshell.exe ..\generate\gen_exclui.prg   --table setor
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_ip
hbmshell.exe ..\generate\gen_altera.prg   --view frm_ip
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_ip
hbmshell.exe ..\generate\gen_exclui.prg   --table ip
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_local
hbmshell.exe ..\generate\gen_altera.prg   --view frm_local
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_local
hbmshell.exe ..\generate\gen_exclui.prg   --table local
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_patr_gr
hbmshell.exe ..\generate\gen_altera.prg   --view frm_patr_gr
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_patr_gr
hbmshell.exe ..\generate\gen_exclui.prg   --table patr_gr
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_prof
hbmshell.exe ..\generate\gen_altera.prg   --view frm_prof
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_prof
hbmshell.exe ..\generate\gen_exclui.prg   --table prof
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_projeto
hbmshell.exe ..\generate\gen_altera.prg   --view frm_projeto
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_projeto
hbmshell.exe ..\generate\gen_exclui.prg   --table projeto
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_patr
hbmshell.exe ..\generate\gen_altera.prg   --view frm_patr
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_patr
hbmshell.exe ..\generate\gen_exclui.prg   --table patr
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_digital
hbmshell.exe ..\generate\gen_altera.prg   --view frm_digital
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_digital
hbmshell.exe ..\generate\gen_exclui.prg   --table digital
hbmshell.exe ..\generate\gen_inclui.prg   --view frm_faixa
hbmshell.exe ..\generate\gen_altera.prg   --view frm_faixa
hbmshell.exe ..\generate\gen_consulta.prg   --view frm_faixa
hbmshell.exe ..\generate\gen_exclui.prg   --table faixa
REM  Gerando chaves estrangeiras dos formulários
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr_recolhe --field id_patr
hbmshell.exe ..\generate\gen_lista_fk.prg   --table fornecedor --field id_grupfor
hbmshell.exe ..\generate\gen_lista_fk.prg   --table material --field id_almox
hbmshell.exe ..\generate\gen_lista_fk.prg   --table tarefa_item --field id_tarefa
hbmshell.exe ..\generate\gen_lista_fk.prg   --table material_transfer --field id_local_destino
hbmshell.exe ..\generate\gen_lista_fk.prg   --table material_transfer --field id_material
hbmshell.exe ..\generate\gen_lista_fk.prg   --table material_transfer --field id_patr
hbmshell.exe ..\generate\gen_lista_fk.prg   --table material_transfer --field id_prof
hbmshell.exe ..\generate\gen_lista_fk.prg   --table local --field id_setor
hbmshell.exe ..\generate\gen_lista_fk.prg   --table projeto --field id_prof
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr --field id_dono
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr --field id_local
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr --field id_patr_gr
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr --field id_projeto
REM  Gerando chaves estrangeiras dos navegadores
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr_recolhido --field id_local
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr_recolhido --field id_local
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr_recolhido --field id_patr_gr
hbmshell.exe ..\generate\gen_lista_fk.prg   --table patr_recolhido --field id_projeto
