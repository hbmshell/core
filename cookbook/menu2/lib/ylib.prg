/**
============================================================================================================================
ROTINAS DE INTERFACE EM MODO TEXTO (DESEJÁVEL USO DE TELA 125x32 - 4000 pontos)
----------------------------------------------------------------------------------------------------------------------------
Codificação.........: UTF-8
Programador.........: Yugi386
Início do Projeto...: 21/07/2014
Última Atualização..: 
============================================================================================================================
*/
#require "hbct"

#define YLIB_CARAC_VALIDOS_SOMBRA "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*()-_+={}[],.;<>:?/\| "

/** 
----------------------------------------------------------------------------------------------------------------------------
Descrição:
[001] Criar Janela Genérica com controle de cor, posição, cor do título e sombra com 4 posições.
Parâmetros: [ obrigatório = (*) ]
1.  titulo.........: Titulo da janela
2.  l1.............: Linha inicial da janela
3.  c1.............: Coluna inicial da janela
4.  l2.............: Linha final da janela
5.  c2.............: Coluna final da janela
6.  corTitulo......: Cor do Título da janela (Frente e Fundo)
7.  corJanela......: Cor da janela (Frente e Fundo)
8.  tipoSombra.....: pode ser 0, 1, 2, 3, 4, respectivamente, sem sombra, sombra na posição inferior esquerdo, inferior direito, superior esquerdo e superior direito
9.  autocentraliza.: centraliza a janela na tela (0 = desativado, 1= centraliza vertical, 2=centraliza horizontal, 3=centraliza vert. e Horizontal
10. alinha_titulo..: alinha o título da janela à esquerda (1), à direita (2) ou centralizado (3)
11. formata_titulo.: se 0 ou NIL = normal
                     se 1 = converte para maiúsculo
                     se 2 = converte minúsculo
                     se 3 = maiúsculo com espaços
                     se 4 = minúsculo com espacos
                     se 5 = normal com espaços
12. corSombra......: Cor da sombra
--------------------------------------------------------------------------------------------------------------------
*/

function ylib_janela(titulo,l1,c1,l2,c2,corTitulo,corJanela,tipoSombra,autocentraliza,alinha_titulo,formata_titulo,corSombra)
local tam, t1, t2, ncor

        ncor := setColor()

        // Verificando dados omissos e valores default

        titulo = iif(titulo==NIL,"Janela",alltrim(titulo))
        autocentraliza = iif(autocentraliza==NIL,3,autocentraliza)
        tipoSombra = iif(tipoSombra==NIL,1,tipoSombra)

	    if corTitulo == NIL
		    corTitulo = "W/G"
	    endif

	    if corJanela == NIL
		    corJanela = "N/W"
	    endif

        if alinha_titulo == nil
            alinha_titulo = 1
        endif

        if formata_titulo == nil
            formata_titulo = 0
        endif

        if corSombra == NIL
            corSombra = "N+/N"
        endif

        l1 = iif(l1==NIL,0,l1)
        l1 = iif(l1>maxrow(),maxrow()-11,l1)

        l2 = iif(l2==NIL,l1+10,l2)
        l2 = iif(l2>maxrow(),maxrow()-1,l2)

        c1 = iif(c1==NIL,0,c1)
        c1 = iif(c1>maxcol(),maxcol()-40,c1)

        c2 = iif(c2==NIL,c1+30,c2)
        c2 = iif(c2>maxcol(),maxrow()-1,c2)

        if (l1 > l2)    //  ordenando l1 e l2
            t1 := l1
            l1 := l2
            l2 := t1
        endif

        if (c1 > c2)    //  ordenando c1 e c2
            t1 := c1
            c1 := c2
            c2 := t1
        endif

        // Centralizando a janela automaticamente

        if autocentraliza == 1  //  centralizando a janela verticalmente
            t1 = l2 - l1
            t2 = int((maxrow()+1-t1)/2)
            l1 = t2
            l2 = t2 + t1
        elseif autocentraliza == 2 // centraliza horizontalmente
            t1 = c2 - c1
            t2 = int((maxcol()+1-t1)/2)
            c1 = t2
            c2 = t2 + t1
        elseif autocentraliza == 3 // centraliza horizontalmente e verticalmente
            t1 = c2 - c1
            t2 = int((maxcol()+1-t1)/2)
            c1 = t2
            c2 = t2 + t1
            t1 = l2 - l1
            t2 = int((maxrow()+1-t1)/2)
            l1 = t2
            l2 = t2 + t1
        endif

	// Posicionamento da sombra da Janela
	do case
		case tipoSombra == 1	// inferior esquerdo
			ylib_Sombra(l1+1,c1-1,l2+1,c2-1,corSombra,l1,c1,l2,c2)
		case tipoSombra == 2	// inferior direito
			ylib_Sombra(l1+1,c1+1,l2+1,c2+1,corSombra,l1,c1,l2,c2)
		case tipoSombra == 3	// superior esquerdo
			ylib_Sombra(l1-1,c1-1,l2-1,c2-1,corSombra,l1,c1,l2,c2)
		case tipoSombra == 4	// superior direito
			ylib_Sombra(l1-1,c1+1,l2-1,c2+1, corSombra,l1,c1,l2,c2)
	endcase

	// Posicionamento da Janela e Título
	setcolor(corJanela)		
	@ l1,c1 clear to l2,c2
	setcolor(corTitulo)		
	@ l1,c1 clear to l1,c2
    
    // Formatação do Tíulo
    if formata_titulo == 1
        titulo = ylib_caixaAltaBaixa(titulo,1)
    elseif formata_titulo == 2
        titulo = ylib_caixaAltaBaixa(titulo,2)
    elseif formata_titulo == 3
        titulo = ylib_caixaAltaBaixa(charmix(titulo," "),1)
    elseif formata_titulo == 4
        titulo = ylib_caixaAltaBaixa(charmix(titulo," "),2)
    elseif formata_titulo == 5
        titulo = charmix(titulo," ")
    endif    

    // posicionamento do titulo
    if alinha_titulo = 1    //  à esquerda
    	@ l1,c1+1 say titulo
    elseif alinha_titulo = 2    //  à direita
        tam = ylib_len(alltrim(titulo))
    	@ l1,c2-tam say titulo
    elseif alinha_titulo = 3    //  centralizado
        tam = ylib_len(alltrim(titulo))
        t1 = int(((c2-c1+1)-tam)/2)
    	@ l1,c1+t1 say titulo
    endif

    setColor(nCor)

return nil

/**
--------------------------------------------------------------------------------------------------------------------
Descrição:
[002] Sombra Real na tela
Parâmetros:
01. l1...: Linha inicial
02. c1...: Coluna Inicial
03. l2...: Linha final
04. c2...: Coluna final
5. coordenadas: coordenadas jl1, jc1, jl2, jc2 da janela para otimizar a sombra (opcional)
---------------------------------------------------------------------------------------------------------------------
*/

function ylib_Sombra(l1,c1,l2,c2,corSombra,jl1,jc1,jl2, jc2)
	local ret := "", ct:= 0, tela, coluna:=c1, linha:=l1, cor, tam:=0, acumula := ""
	
	tela :=savescreen(l1,c1,l2,c2)
	
	cor := setcolor()

    if corSombra==NIL
    	setcolor("N+/N")
    else
        setcolor(corSombra)
    endif

    tela := hb_utf8tostr(tela)
 
   for ct:= 3 to ylib_len(tela) step 4
       tela := stuff(tela,ct,1,chr(8))
   next
   restscreen(l1,c1,l2,c2,tela)

    setcolor(cor)

    return NIL

	tam := len(tela)

	for ct:= 1 to tam step 4
        if jl1 == NIL
            if (substr(tela,ct,1) $ YLIB_CARAC_VALIDOS_SOMBRA)
        		@ linha,coluna say substr(tela,ct,1)
            else    
                @ linha,coluna say " "
            endif
        else    //  rotina para otimizar a apresentação da sombra das janelas
            if linha < jl1 .OR. linha > jl2 .OR. coluna < jc1 .OR. coluna > jc2
                if (substr(tela,ct,1) $ YLIB_CARAC_VALIDOS_SOMBRA)
            		@ linha,coluna say substr(tela,ct,1)
                else    
                    @ linha,coluna say " "
        		    // @ linha,coluna say substr(tela,ct,1)
                endif
            endif
        endif

		++ coluna
		if coluna > c2
			coluna = c1
			++ linha
		endif

		if linha > l2
			exit
		endif

	next
	setcolor(cor)

return nil

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[003] Construindo a Janela Principal do Programa
Parâmetros:
1. mTitulo.....: Título da tela principal do programa
2. CorTitulo...: Cor do título da janela (frente e fundo)
3. CorJanela...: Cor da Janela Principal do sistema
4. CorMenu.....: Cor do Menu principal do sistema
5. CorStatus...: Cor da barra de status do sistema (frente e fundo)
6. linhaStatus.: Linha da barra de status
7. formata_titulo.: se 0 ou NIL = normal
                     se 1 = converte para maiúsculo
                     se 2 = converte minúsculo
                     se 3 = maiúsculo com espaços
                     se 4 = minúsculo com espacos
                     se 5 = normal com espaços
8. centraliza_titulo.: se 1 = centralizado, se 0 = à esquerda
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_JanelaMain(mTitulo,CorTitulo,CorJanela,CorMenu,CorStatus,linhaStatus,formata_titulo,centraliza_titulo)

	if CorTitulo == nil
		CorTitulo = "W+/B"
	endif
	
	if CorJanela == nil
		CorJanela = "N/BG"
	endif

	if CorMenu = nil
		CorMenu = "N/W,W+/R"
	endif

	if CorStatus = nil
		CorStatus = "N/W,W+/R"
	endif

    if centraliza_titulo == NIL
        centraliza_titulo := 1
    endif

	setcolor(CorJanela)
	ylib_cls()

    if formata_titulo == nil
        formata_titulo := 0
    endif
	
    // Formatação do Título
    if formata_titulo == 1
        mtitulo = ylib_caixaAltaBaixa(mtitulo,1)
    elseif formata_titulo == 2
        mtitulo = ylib_caixaAltaBaixa(mtitulo,2)
    elseif formata_titulo == 3
        mtitulo = ylib_caixaAltaBaixa(charmix(mtitulo," "),1)
    elseif formata_titulo == 4
        mtitulo = ylib_caixaAltaBaixa(charmix(mtitulo," "),2)
    elseif formata_titulo == 5
        mtitulo = charmix(mtitulo," ")
    endif    

	setcolor(CorTitulo)
	@ 00,00 clear to 00,maxcol()
    if centraliza_titulo == 1
    	ylib_center(00,alltrim(mTitulo),CorTitulo,maxcol()+1,0)
    else
        @ 00,01 say alltrim(mtitulo)
    endif

    if linhaStatus==NIL
        linhaStatus := maxrow()
    endif

	setcolor(CorStatus)
	@ linhaStatus,00 clear to linhaStatus,maxcol()

	setcolor(CorMenu)
	@ 01,00 clear to 01,maxcol()

return nil

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[004] Limpa toda a tela, ou as coordenadas especificadas
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_cls(l1,c1,l2,c2)
	if pcount()==0
		@ 00,00 clear to maxrow(),maxcol()
	else
		@ l1,c1 clear to l2,c2
	endif
return nil

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[005] Cria um Menu Horizontal
Parâmetros:
1. l1...........: Linha inicial do Menu
2. c1...........: Coluna inicial do Menu
3. opcoes.......: Matriz com opções e mensagens de status do Menu e opção habilitado/desabilitado
4. corMenu......: Cor do menu padrão e selecionado
5. espacamento..: Espaçamento entre os menus
6. lstatus......: linha de mensagem de status
7. cormenudesabilitado.: cor do menu que estiver desabilitado
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_criaMenu(l1,c1,opcoes,corMenu,espacamento,lstatus,corMenuDesabilitado)
	local tam := 0, ct:=0, opc:= 0, desabilitados:={}, opcoes_menu:={}, opcoes_menu_fim:={}

    for ct:= 1 to len(opcoes)   
        aadd(opcoes_menu,ct)
    next

	if corMenu == nil
		corMenu = "N/W,W+/R"
	endif

    if corMenuDesabilitado == nil
		corMenuDesabilitado = "W/B"
	endif

	if espacamento == nil
		espacamento = 2
	endif

    if lstatus == NIL
        lstatus = maxrow()
    endif

	tam:= len(opcoes)

	setcolor(corMenu)
    @l1,00 clear to l1,maxcol()
	ylib_cls(lstatus,00,lstatus,maxcol())

	for ct:= 1 to tam
        if opcoes[ct][3] == NIL
            opcoes[ct][3] = .T.
        endif

        // controle para menus desabilitados
        if opcoes[ct][3] == .T.
            setcolor(corMenu)
		    @ l1,c1 prompt opcoes[ct][1] message alltrim(opcoes[ct][2])
        else
        	setcolor(corMenuDesabilitado)
            @ l1,c1 say opcoes[ct][1]
            aadd(desabilitados,ct)  //  verificamos quais os menus desabilitados
        endif
		c1 = c1 + ylib_len(opcoes[ct][1]) + espacamento
        setcolor(corMenu)
	next
	menu to opc

    // verificando qual a opcao escolhida (considerando os menus desabilitados)

    for ct:= 1 to len(desabilitados)
        opcoes_menu[desabilitados[ct]] := NIL
    next

    for ct:= 1 to len(opcoes_menu)
        if (opcoes_menu[ct]<>NIL)
            aadd(opcoes_menu_fim,opcoes_menu[ct])
        endif
    next

    if opc <> 0
        opc := opcoes_menu_fim[opc]
    endif

return opc

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[006] Cria um Menu Vertical
Parâmetros:
1. l1...........: Linha inicial do Menu
2. c1...........: Coluna inicial do Menu
3. opcoes.......: Matriz com opções e mensagens de status do Menu
4. corMenu......: Cor do menu padrão e selecionado
5. lstatus......: linha de mensagem de status
6. cormenudesabilitado.: cor do menu que estiver desabilitado
7. tipoSombra...: pode ser 0, 1, 2, 3, 4, respectivamente, sem sombra, sombra na posição inferior esquerdo, inferior direito, superior esquerdo e superior direito
8. corsombra....: cor da sombra (padrao n+/n)
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_criaMenuVertical(l1,c1,opcoes,corMenu,lstatus,corMenuDesabilitado,tiposombra,corSombra)
	local tam := 0, ct:=0, opc:= 0, maxMenu:=0, l2, c2, contador:=1, desabilitados:={}, opcoes_menu:={}, opcoes_menu_fim:={}
	local sep_menu_direito:= chr(226) + chr(148) + chr(164),;
		  sep_menu_esquerdo:= chr(226) + chr(148) + chr(156)
    local atalhos := {"1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n",;
                "o","p","q","r","s","t","u","v","w","x","y","z"}

    contador := 1
     for ct:= 1 to len(opcoes)
         if (opcoes[ct][1] <> "-")   
             aadd(opcoes_menu,contador)
            ++ contador
         endif
     next

    if corMenu == nil
		corMenu = "N/W,W+/R"
	endif

	if lstatus == nil
		lstatus = maxrow()
	endif

    if corMenuDesabilitado == nil
		corMenuDesabilitado = "R+/W"
	endif

    if tiposombra == nil
        tiposombra = 1
    endif
	// verificando o tamanho do Menu
	tam:= len(opcoes)

	for ct:= 1 to tam
		maxMenu = Max(maxMenu,ylib_len(alltrim(opcoes[ct][1])))
	next

	l2 = l1 + tam + 1
	c2 = c1 + 8 + maxMenu

	setcolor(corMenu)
	ylib_cls(lstatus,00,lstatus,maxcol())

    // Posicionamento da sombra da Janela
	do case
		case tipoSombra == 1	// inferior esquerdo
			ylib_Sombra(l1+1,c1-1,l2+1,c2-1,corSombra,l1,c1,l2,c2)
		case tipoSombra == 2	// inferior direito
			ylib_Sombra(l1+1,c1+1,l2+1,c2+1,corSombra,l1,c1,l2,c2)
		case tipoSombra == 3	// superior esquerdo
			ylib_Sombra(l1-1,c1-1,l2-1,c2-1,corSombra,l1,c1,l2,c2)
		case tipoSombra == 4	// superior direito
			ylib_Sombra(l1-1,c1+1,l2-1,c2+1, corSombra,l1,c1,l2,c2)
	endcase

	@ l1,c1 clear to l2,c2	
	@ l1,c1+1 to l2,c2-1
	++l1

    contador := 1
	for ct:= 1 to tam
		if alltrim(opcoes[ct][1]) == "-"
            setcolor(corMenu)
			@ l1,c1+1 say sep_menu_esquerdo
			@ l1,c1+2 to l1,c2-2
			@l1,c2-1 say sep_menu_direito
		else	
             if opcoes[ct][3] == NIL
                opcoes[ct][3] = .T.
             endif

            // controle para menus desabilitados
            if opcoes[ct][3] == .T.
                setcolor(corMenu)
			    @ l1,c1+2 prompt alltrim(atalhos[contador]) + ". " + padr(opcoes[ct][1],c2-c1-6+(len(opcoes[ct][1])-ylib_len(opcoes[ct][1]))," ") message alltrim(opcoes[ct][2])
            else
                setcolor(corMenuDesabilitado)
			    @ l1,c1+2 say alltrim(atalhos[contador]) + ". " + padr(opcoes[ct][1],c2-c1-6+(len(opcoes[ct][1])-ylib_len(opcoes[ct][1]))," ")
                aadd(desabilitados,contador)  //  verificamos quais os menus desabilitados
            endif
        	++contador
	    endif

    	++l1
        setcolor(corMenu)
	next
	menu to opc

 // verificando qual a opcao escolhida (considerando os menus desabilitados)

    for ct:= 1 to len(desabilitados)
        opcoes_menu[desabilitados[ct]] := NIL
    next

    for ct:= 1 to len(opcoes_menu)
        if (opcoes_menu[ct]<>NIL)
            aadd(opcoes_menu_fim,opcoes_menu[ct])
        endif
    next

    if opc <> 0
        opc := opcoes_menu_fim[opc]
    endif

return opc

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[007] Cria um Menu Completo (Horizontal + Vertical Multinível)
Parâmetros:
1. l1...........: Linha inicial do Menu
2. c1...........: Coluna inicial do Menu
3. opcoes.......: Matriz com opções e mensagens de status do Menu, opção habilitado/desabilitado, deslocamento(linha e coluna do menu)
4. corMenu......: Cor do menu padrão e selecionado
5. espacamento..: Espaçamento entre os menus
6. lstatus......: linha de mensagem de status
7. cormenudesabilitado.: cor do menu que estiver desabilitado
8. tipoSombra...: pode ser 0, 1, 2, 3, 4, respectivamente, sem sombra, sombra na posição inferior esquerdo, inferior direito, superior esquerdo e superior direito
9. corsombra....: cor da sombra (padrao n+/n)
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_mainMenu(l1,c1,opcoes,corMenu,espacamento,lstatus,corMenuDesabilitado,tipoSombra,corSombra)
	local contador := 0, ct:=0, opc:= 0, mHorizontal:={}, mVertical:={}, ct2, tela, ret:="", telaTotal, maxMenu := 0,;
        tagSubmenu := " " + chr(226) + chr(150) + chr(182) + " ", escolhaOpcao:=array(5), tam, tamMenu:=array(4), nivel,;
        tela1, tela2, tela3, tela4
    private navega:=0

save screen to telaTotal
nivel := 0  //  variavel para controlar o retorno do menu via <ESC>

do while.t.
    if nivel <> 0   //  controla a posicao dos menus quando voltamos com esc
        marca := .t.
    else
        marca:=.f.
    endif
    navega:=0

    if nivel == 0   //  nivel inicial - Menu Horizontal

            restore screen from telaTotal

            // reiniciando os gerenciadores de retorno e os vetores temporários...
            ret:=""
            mHorizontal:={}
            mVertical:={}

            // Pegando os menus horizontais:
            for ct:= 1 to len(opcoes)
                if ylib_len(alltrim(opcoes[ct][1])) <> 0
                    aadd(mHorizontal,{opcoes[ct][1],opcoes[ct][2],opcoes[ct][3]})
                endif
            next

            opcoesHorizontais := len(mHorizontal)   //  total de opcoes do menu horizontal...

            opc := ylib_criaMenu(l1,c1,mHorizontal,corMenu,espacamento,lstatus,corMenuDesabilitado)

            escolhaopcao[1] = opc   //  guarda o menu escolhido
            ret := alltrim(str(opc))    //  gerencia o retorno da função

            if opc == 0
                exit
            endif

            nivel := 1  //  nivel é igual a um
    endif   //  fim do nivel = 0 - inicial menu horizontal

     // gerenciando o menu vertical de nível 1 =====================================================================
     // Pegando os menus verticais

    if nivel <= 1

        contador := 0
         for ct2:= 1 to len(opcoes)
            if ylib_len(alltrim(opcoes[ct2][1])) <> 0
                ++ contador
            endif

            // verificando a opção escolhida
            if contador == escolhaopcao[1]
                if ylib_len(alltrim(opcoes[ct2][1])) == 0
                    if ylib_len(alltrim(opcoes[ct2][2])) <> 0
                        aadd(mVertical,{opcoes[ct2][2],opcoes[ct2][3],opcoes[ct2][4]})
                    else
                        if !(tagSubmenu $ mVertical[len(mVertical)][1]) 
                            mVertical[len(mVertical)][1] += tagSubmenu  //  verificando submenus vinculados
                        endif
                    endif
                endif
            endif
       next

        // Verificando a posição do Menu Vertical
        xc1 = c1
        for ct:= 2 to escolhaopcao[1]
            xc1 += ylib_len(mHorizontal[ct][1]) + espacamento
            if ct==escolhaopcao[1]
                exit
            endif
        next

        tamMenu[1] :=0  //  tamanho menu
        for ct:=1 to len(mVertical)
            tamMenu[1]:=max(tamMenu[1],ylib_len(mVertical[ct][1]))
        next
        tamMenu[1]:=tamMenu[1]+4

        save screen to tela1

        set key 4 to ylib_avancarMenuHorizontal()
        set key 19 to ylib_voltarMenuHorizontal()

            opc := ylib_criaMenuVertical(l1+1,xc1,mVertical,corMenu,lstatus,corMenuDesabilitado,tiposombra,corSombra)
            escolhaopcao[2] = opc   //  guarda o menu escolhido

        set key 4 to
        set key 19 to

        // verificando menus horizontais desabilitados...
        verDesabi:= 0
        for ct:= 1 to len(mHorizontal)
            if mHorizontal[ct][3] == .f.
                ++verdesabi
            endif
            if ct == escolhaopcao[1]
                exit
            endif
        next    

        if lastkey() == 27  .and. navega==1
            keyboard replicate(chr(4),escolhaopcao[1]-verdesabi)+chr(13)
            nivel := 0
            loop
        endif

        if lastkey() == 27  .and. navega==2
            keyboard replicate(chr(4),escolhaopcao[1]-1-verdesabi)+replicate(chr(19),1)+chr(13)
            nivel := 0
            loop
        endif

        ret += "."+alltrim(str(opc))    //  gerencia o retorno da função

     // Verificando a opção escolhida (excluindo separadores de menu)
        contador := 0
        for ct:= 1 to len(mVertical)
            if (alltrim(mVertical[ct][1]) <> "-")
                ++contador
            endif
            if opc == contador
                verifica := mVertical[ct][1]
                exit
            endif
        next

        if opc == 0     //  tecla ESC
            restore screen from tela1
            nivel := 0  //  retorna para o nivel 0 inicial
            loop
        else
            if !(tagSubmenu $ verifica)    //  se não tem um submenu cai fora
                exit    
            endif
        endif

        nivel := 2

    endif   // fim nivel = 1

     // gerenciando o menu vertical de nível 2 =====================================================================
     // Pegando os menus verticais

    if nivel <= 2   //  nivel 2 do menu

            if marca =.f.
                mverticalOLD:= mVertical
            endif

            mVertical := {}
            contador := 0

             for ct2:= 1 to len(opcoes)
                if ylib_len(alltrim(opcoes[ct2][1])) <> 0
                    ++ contador
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[1]
                    ct:= ct2
                    exit
                endif
           next

            contador:=0
             for ct2:= (ct+1) to len(opcoes)
                if ylib_len(alltrim(opcoes[ct2][2])) <> 0 .and. alltrim(opcoes[ct2][2]) <> "-"
                    ++ contador
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[2]

                    if ct2 > len(opcoes)  //  Verifica o estouro da matriz
                        exit
                    endif

                    if ylib_len(alltrim(opcoes[ct2][2])) == 0
                        if upper(transform(opcoes[ct2][3],"L")) <> "T" .and. upper(transform(opcoes[ct2][3],"L")) <> "F"
                            if ylib_len(alltrim(opcoes[ct2][3])) <> 0
                                aadd(mVertical,{opcoes[ct2][3],opcoes[ct2][4],opcoes[ct2][5],opcoes[ct2][6]})
                            else
                                if !(tagSubmenu $ mVertical[len(mVertical)][1]) 
                                    mVertical[len(mVertical)][1] += tagSubmenu  //  verificando submenus vinculados
                                endif
                            endif
                        endif
                    endif
                endif
           next

            // Verificando a posição do Menu Vertical
            xc1 = c1
            for ct:= 2 to escolhaopcao[1]
                xc1 += ylib_len(mHorizontal[ct][1]) + espacamento
            next

            // Verificando o tamanho do primeiro menu vertical
            tam:= 0
            tamvertical :=0
            contador:=0

            for ct:= 1 to len(mVerticalOLD)
                tam:= max(tam,ylib_len(mVerticalOLD[ct][1]))

               if ylib_len(alltrim(mVerticalOLD[ct][1])) <> 0 .and. alltrim(mVerticalOLD[ct][2]) <> "-"
                    ++ contador
                endif

                if contador <= escolhaopcao[2] .and. mVerticalOLD[ct][1] == "-"
                    ++tamvertical
                endif
            next

            deslocamento = mVertical[1][4]
            // xc1 += int(tam/2.5) + deslocamento[2] //  posicao do menu vertical 2
            xc1 += int(tamMenu[1]/4) + deslocamento[2]

            tamMenu[2] :=0  //  tamanho menu
            for ct:=1 to len(mVertical)
                tamMenu[2]:=max(tamMenu[2],ylib_len(mVertical[ct][1]))
            next
            tamMenu[2]:=tamMenu[2]+4

            save screen to tela2

                opc := ylib_criaMenuVertical(l1+1+escolhaopcao[2]+tamVertical+1+deslocamento[1],xc1,mVertical,corMenu,lstatus,corMenuDesabilitado,tiposombra,corSombra)
                escolhaopcao[3] = opc   //  guarda o menu escolhido

            ret += "."+alltrim(str(opc))    //  gerencia o retorno da função

         // Verificando a opção escolhida (excluindo separadores de menu)
            contador := 0
            for ct:= 1 to len(mVertical)
                if (alltrim(mVertical[ct][1]) <> "-")
                    ++contador
                endif
                if opc == contador
                    verifica := mVertical[ct][1]
                    exit
                endif
            next

            if opc == 0     //  tecla ESC
                restore screen from tela2   
                // Rotina para voltar ao menu anterior usando ESC
                mVertical = {}
                nivel := 1
                for ct:= 1 to 2    
                    tmp := rat(".",ret)
                    ret := substr(ret,1,tmp-1)
                next
                restore screen from tela1
                loop
            else
                if !(tagSubmenu $ verifica)    //  se não tem um submenu cai fora
                    exit    
                endif
            endif

                nivel := 3
    endif   //  fim do nivel 2 do menu

     // gerenciando o menu vertical de nível 3 =====================================================================
     // Pegando os menus verticais

    if nivel <= 3       //  nivel 3 do menu

            if marca =.f.
                mverticalOLD:= mVertical
            endif

            mVertical := {}
            contador := 0

             for ct2:= 1 to len(opcoes)     // primeira opcao
                if ylib_len(alltrim(opcoes[ct2][1])) <> 0
                    ++ contador
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[1]
                    ct:= ct2
                    exit
                endif
             next

            contador:=0     //  segunda opcao
            for ct2:= (ct+1) to len(opcoes)
                if ylib_len(alltrim(opcoes[ct2][2])) <> 0 .and. alltrim(opcoes[ct2][2]) <> "-"
                    ++ contador
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[2]
                    ct:= ct2
                    exit
                endif
             next

            contador:=0
             for ct2:= (ct+1) to len(opcoes)    //  terceira opcao
                if upper(transform(opcoes[ct2][3],"L")) <> "T" .and. upper(transform(opcoes[ct2][3],"L")) <> "F"
                    if ylib_len(alltrim(opcoes[ct2][3])) <> 0 .and. alltrim(opcoes[ct2][3]) <> "-"
                        ++ contador
                    endif
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[3]

                    if ct2 > len(opcoes)  //  Verifica o estouro da matriz
                        exit
                    endif

                    if valtype(opcoes[ct2][4]) == "L" .or.valtype(opcoes[ct2][4]) == "A" .or. ;
                        valtype(opcoes[ct2][3]) == "L" .or.valtype(opcoes[ct2][3]) == "A"
                        loop
                    endif


                    if !ylib_isarray(opcoes[ct2][4])
                       if upper(transform(opcoes[ct2][4],"L")) <> "T" .and. upper(transform(opcoes[ct2][4],"L")) <> "F"
                           if ylib_len(alltrim(opcoes[ct2][3])) == 0
                                if ylib_len(alltrim(opcoes[ct2][4])) <> 0
                                    aadd(mVertical,{opcoes[ct2][4],opcoes[ct2][5],opcoes[ct2][6],opcoes[ct2][7]})
                                else
                                    if !(tagSubmenu $ mVertical[len(mVertical)][1]) 
                                        mVertical[len(mVertical)][1] += tagSubmenu  //  verificando submenus vinculados
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
           next

            // Verificando a posição do Menu Vertical
            xc1 = c1
            for ct:= 2 to escolhaopcao[1]
                xc1 += ylib_len(mHorizontal[ct][1]) + espacamento
            next

            // Verificando o tamanho do primeiro menu vertical
            tam:= 0
            tamvertical :=0
            contador:=0

            for ct:= 1 to len(mVerticalOLD)
                tam:= max(tam,ylib_len(mVerticalOLD[ct][1]))

               if ylib_len(alltrim(mVerticalOLD[ct][1])) <> 0 .and. alltrim(mVerticalOLD[ct][2]) <> "-"
                    ++ contador
                endif

                if contador <= escolhaopcao[2] .and. mVerticalOLD[ct][1] == "-"
                    ++tamvertical
                endif
            next

            deslocamento = mVertical[1][4]
            // xc1 += (int(tam/2.5) * 2) +deslocamento[2] //+nTam //  posicao do menu vertical 2
            xc1 += int((tamMenu[1]/4)+(tamMenu[2]/4)) + deslocamento[2]

           tamMenu[3] :=0  //  tamanho menu
            for ct:=1 to len(mVertical)
                tamMenu[3]:=max(tamMenu[3],ylib_len(mVertical[ct][1]))
            next
            tamMenu[3]:=tamMenu[3]+4

            save screen to tela3

                opc := ylib_criaMenuVertical(l1+1+escolhaopcao[2]+escolhaopcao[3]+tamVertical+2+deslocamento[1],xc1,mVertical,corMenu,lstatus,corMenuDesabilitado,tiposombra,corSombra)
                escolhaopcao[4] = opc   //  guarda o menu escolhido

            ret += "."+alltrim(str(opc))    //  gerencia o retorno da função

         // Verificando a opção escolhida (excluindo separadores de menu)
            contador := 0
            for ct:= 1 to len(mVertical)
                if (alltrim(mVertical[ct][1]) <> "-")
                    ++contador
                endif
                if opc == contador
                    verifica := mVertical[ct][1]
                    exit
                endif
            next

            if opc == 0     //  tecla ESC
                restore screen from tela3
                 mVertical = {}
                  nivel := 2
                  for ct:= 1 to 2    
                      tmp := rat(".",ret)
                      ret := substr(ret,1,tmp-1)
                  next
                   restore screen from tela2
                  loop
            else
                if !(tagSubmenu $ verifica)    //  se não tem um submenu cai fora
                    exit    
                endif
            endif

            menu := 4
    endif   //  fim do nivel 3 do menu

     // gerenciando o menu vertical de nível 4 =====================================================================
     // Pegando os menus verticais

    if nivel <= 4   //  nivel 4 do menu

            if marca =.f.
                mverticalOLD:= mVertical
            endif

            mVertical := {}
            contador := 0

             for ct2:= 1 to len(opcoes)     // primeira opcao
                if ylib_len(alltrim(opcoes[ct2][1])) <> 0
                    ++ contador
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[1]
                    ct:= ct2
                    exit
                endif
             next

            contador:=0     //  segunda opcao
            for ct2:= (ct+1) to len(opcoes)
                if ylib_len(alltrim(opcoes[ct2][2])) <> 0 .and. alltrim(opcoes[ct2][2]) <> "-"
                    ++ contador
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[2]
                    ct:= ct2
                    exit
                endif
             next

            contador:=0     //  terceira opcao
            for ct2:= (ct+1) to len(opcoes)
                if upper(transform(opcoes[ct2][3],"L")) <> "T" .and. upper(transform(opcoes[ct2][3],"L")) <> "F"
                    if ylib_len(alltrim(opcoes[ct2][3])) <> 0 .and. alltrim(opcoes[ct2][3]) <> "-"
                        ++ contador
                    endif
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[3]
                    ct:= ct2
                    exit
                endif
             next

            contador:=0
             for ct2:= (ct+1) to len(opcoes)    //  quarta opcao
                if !ylib_isarray(opcoes[ct2][4])
                    if upper(transform(opcoes[ct2][4],"L")) <> "T" .and. upper(transform(opcoes[ct2][4],"L")) <> "F"
                        if ylib_len(alltrim(opcoes[ct2][4])) <> 0 .and. alltrim(opcoes[ct2][4]) <> "-"
                            ++ contador
                        endif
                    endif
                endif

                // verificando a opção escolhida
                if contador == escolhaopcao[4]

                    if ct2 > len(opcoes)  //  Verifica o estouro da matriz
                        exit
                    endif


                    if !ylib_isarray(opcoes[ct2][5])
                        if upper(transform(opcoes[ct2][5],"L")) <> "T" .and. upper(transform(opcoes[ct2][5],"L")) <> "F"
                            if ylib_len(alltrim(opcoes[ct2][4])) == 0
                                if ylib_len(alltrim(opcoes[ct2][5])) <> 0
                                    aadd(mVertical,{opcoes[ct2][5],opcoes[ct2][6],opcoes[ct2][7],opcoes[ct2][8]})
                                else
                                    if !(tagSubmenu $ mVertical[len(mVertical)][1]) 
                                        mVertical[len(mVertical)][1] += tagSubmenu  //  verificando submenus vinculados
                                    endif
                                endif
                            endif
                        endif    
                    endif
                endif
           next

            // Verificando a posição do Menu Vertical
            xc1 = c1
            for ct:= 2 to escolhaopcao[1]
                xc1 += ylib_len(mHorizontal[ct][1]) + espacamento
            next

            // Verificando o tamanho do primeiro menu vertical
            tam:= 0
            tamvertical :=0
            contador:=0

            for ct:= 1 to len(mVerticalOLD)
                tam:= max(tam,ylib_len(mVerticalOLD[ct][1]))

               if ylib_len(alltrim(mVerticalOLD[ct][1])) <> 0 .and. alltrim(mVerticalOLD[ct][2]) <> "-"
                    ++ contador
                endif

                if contador <= escolhaopcao[2] .and. mVerticalOLD[ct][1] == "-"
                    ++tamvertical
                endif
            next

            deslocamento = mVertical[1][4]
            // xc1 += (int(tam/2.5) * 4) + deslocamento[2] // +int(nTam/2) //  posicao do menu vertical 3
            xc1 += int((tamMenu[1]/4)+(tamMenu[2]/4)+(tamMenu[3]/4)) + deslocamento[2]

           tamMenu[4] :=0  //  tamanho menu
            for ct:=1 to len(mVertical)
                tamMenu[4]:=max(tamMenu[4],ylib_len(mVertical[ct][1]))
            next
            tamMenu[4]:=tamMenu[4]+4

            save screen to tela4

                opc := ylib_criaMenuVertical(l1+1+escolhaopcao[2]+escolhaopcao[3]+escolhaopcao[4]+tamVertical+3+deslocamento[1],xc1,mVertical,corMenu,lstatus,corMenuDesabilitado,tiposombra,corSombra)
                escolhaopcao[5] = opc   //  guarda o menu escolhido

            ret += "."+alltrim(str(opc))    //  gerencia o retorno da função

         // Verificando a opção escolhida (excluindo separadores de menu)
            contador := 0
            for ct:= 1 to len(mVertical)
                if (alltrim(mVertical[ct][1]) <> "-")
                    ++contador
                endif
                if opc == contador
                    verifica := mVertical[ct][1]
                    exit
                endif
            next

            if opc == 0     //  tecla ESC
                restore screen from tela4
                mVertical = {}
                  nivel := 3
                  for ct:= 1 to 2    
                      tmp := rat(".",ret)
                      ret := substr(ret,1,tmp-1)
                  next
                    restore screen from tela3
                  loop
            else
                if !(tagSubmenu $ verifica)    //  se não tem um submenu cai fora
                    exit    
                endif
            endif

    endif   //  fim do nivel 4 do menu

    exit    //  retirar para mais níveis...
enddo

return ret

//==================================================================================
function ylib_isarray(vet)   //  verifica se a entrada e um vetor
local ret := .t., ct

    if valtype(vet) == "A"
        return .t.
    else
        return .f.
    endif
    /*
    BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
        ct := vet[1]
    RECOVER
        ret:= .F.
    END SEQUENCE
    */

return ret
//===================================================================================
func ylib_avancarMenuHorizontal()
    keyboard chr(27)
    navega:=1
return NIL
// ==================================================================================
func ylib_voltarMenuHorizontal()
    keyboard chr(27)
    navega:=2
return NIL
//===================================================================================
