/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[001] Conta quantos caracteres existem na codificação utf-8 para letras acentuadas
Substitui a função len() quando se usa a codificação utf-8
Parâmetros:
1. palavra.....: String para verificar o tamanho
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_len(palavra)
	local tam:= 0

    palavra := hb_utf8tostr(palavra)    
	tam := len(palavra)

return tam

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[002] Tira Acentos das palavras
Parâmetros:
1. palavra.....: String de entrada
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_tira_acentos(palavra)
	local acento := {"à","á","â","ã","ä","é","è","ê","ë","í","ì","î","ĩ","ï","ò","ó","ô","õ","ö","ù","ú","û","ũ","ü","À","Á","Â","Ã","Ä","È","É","Ê","Ë","Ì","Í","Î","Ĩ","Ï","Ò","Ó","Ô","Õ","Ö","Ù","Ú","Û","Ũ","Ü","Ç","ç","Ñ","ñ"}
	local trocar := {"a","a","a","a","a","e","e","e","e","i","i","i","i","i","o","o","o","o","o","u","u","u","u","u","A","A","A","A","A","E","E","E","E","I","I","I","I","I","O","O","O","O","O","U","U","U","U","U","C","c","N","n"}
	local ct:= 0, tam := len(acento)
	
	for ct:= 1 to tam
		palavra := strtran(palavra,acento[ct],trocar[ct])
	next

return palavra

/** 
--------------------------------------------------------------------------------------------------------------------
Descrição:
[003] Passa para maiúsculo ou minúsculo 
Parâmetros:
1. palavra.....: String de entrada
2. modo........: 1 = converte para maiúsculas e 2 para minúsculas
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_caixaAltaBaixa(palavra,modo)
	local acento := {"à","á","â","ã","ä","é","è","ê","ë","í","ì","î","ĩ","ï","ò","ó","ô","õ","ö","ù","ú","û","ũ","ü","ç","ñ"}
	local trocar := {"À","Á","Â","Ã","Ä","É","È","Ê","Ë","Í","Ì","Î","Ĩ","Ï","Ò","Ó","Ô","Õ","Ö","Ù","Ú","Û","Ũ","Ü","Ç","Ñ"}
	local ct:= 0, tam := len(acento)
	
    if (modo == 1)
	    for ct:= 1 to tam
		    palavra := strtran(palavra,acento[ct],trocar[ct])
	    next

        palavra = upper(palavra)
    elseif (modo==2)
	    for ct:= 1 to tam
		    palavra := strtran(palavra,trocar[ct],acento[ct])
	    next

        palavra = lower(palavra)
    endif

return palavra

/**
--------------------------------------------------------------------------------------------------------------------
Descrição:
[004] Centraliza mensagem na Tela em uma determinada linha ou em uma janela
Parâmetros:
1. linha.........: Linha em que a mensagem vai aparecer
2. mensagem......: Informação a ser apresentada
3. cor...........: Cor que a mensagem será apresentada (Frente e Fundo)
4. tamanhoLinha..: Define o tamanho da linha do sistema (padrão 80)
5. inicio........: Coluna inicial a ser considerada para a centralização da mensagem
--------------------------------------------------------------------------------------------------------------------
*/
function ylib_center(linha,mensagem,cor,tamanhoLinha,inicio)
	local lcor := setcolor(), posicao := 0

	if cor == nil
		cor = "N/W"
	endif

	if tamanhoLinha == nil
		tamanhoLinha = maxcol()
	endif

	if inicio == nil
		inicio = 0
	endif

	posicao = int((tamanhoLinha - ylib_len(alltrim(Mensagem))) / 2) + inicio

	setcolor(cor)	
	@linha,posicao say mensagem

	setcolor(lcor)

return nil



// =============================================================================================================================
/*
Configuraçoes iniciais do sistema
*/
function ylib_iniciar(linhas,colunas,lstatus,modo)

	REQUEST HB_LANG_PT
	REQUEST HB_CODEPAGE_UTF8EX
	HB_LANGSELECT( 'PT' )
	HB_CDPSELECT( "UTF8EX" )	

	set date french
	set century on
	set scoreboard off
	set cursor off
	setblink(.f.)
	set confirm on	
	setmode(linhas,colunas)
    if modo == 1
    	set message to lstatus center
    else
    	set message to lstatus
    endif
	set wrap On
    set exact on

return nil


