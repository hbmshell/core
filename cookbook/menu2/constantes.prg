/*
---------------------------------------------------------------------------
DEFINE VÁRIAS CONSTANTES NECESSÁRIAS PARA O SISTEMA
Codificação: UTF-8
Yugi386
---------------------------------------------------------------------------
*/

*[1] Caracteres Válidos:

	#define YLIB_CARAC_VALIDOS   "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*()-_+={}[],.;<>:?/\| "
	#define YLIB_ACENTOS_VALIDOS "àáâãäéèêëíìîïòóôõöùúûüÀÁÂÃÄÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇçÑñ"

*[2] Cores:

	* Janela Principal
	#define YLIB_COR_TITULO  	"W+/G"
	#define YLIB_COR_JANELA  	"N/B"
	#define YLIB_COR_MENU    	"N/W,W+/R"
	#define YLIB_COR_STATUS  	"N/W"
	#define YLIB_COR_SUBMENU 	"N/W,W+/R"

	* Formulário
	#define YLIB_COR_FORM_TITULO	"W+/G"
	#define YLIB_COR_FORM_JANELA	"N/W"
	#define YLIB_COR_FORM_GET	    "N/W,W/R,,,N/BG"

	* Janelas de Avisos
	#define YLIB_COR_AVISO_TITULO	"W+/B"
	#define YLIB_COR_AVISO_JANELA	"N/W"
	#define YLIB_COR_ERRO_TITULO	"W+/R"
	#define YLIB_COR_ERRO_JANELA	"N/W"
	#define YLIB_COR_ADVERTE_TITULO	"W+/GR"
	#define YLIB_COR_ADVERTE_JANELA	"N/W"

	* Caixas de Diálogo
	#define YLIB_COR_CAIXA_TITULO	"W+/RB"
	#define YLIB_COR_CAIXA_JANELA	"N/W"
	#define YLIB_COR_CAIXA_BOTAO	"N/W,W+/R"

*[3] Dimensões da Tela / Definir Barra de Status

	#define YLIB_TOTAL_COLUNAS 125
	#define YLIB_TOTAL_LINHAS 32
	#define YLIB_LINHA_STATUS 31
