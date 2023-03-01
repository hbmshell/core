/*
  Exemplo de modos de telas com GTWVT
  Compilar: Hbmk2 TelaCheia.Prg -lxhb
*/

#include "inkey.ch"
#include "hbgtinfo.ch"

//REQUEST HB_LANG_PT
//REQUEST HB_CODEPAGE_PT850
//REQUEST HB_GT_WVT_DEFAULT

Function Main()
 Local nModo := 1

 
 HB_GtInfo( HB_GTI_FONTNAME, "Lucida Console" )  // fonte
 HB_GtInfo( HB_GTI_WINTITLE, "Screen mode test" ) // titulo da tela
 
 HB_GtInfo( HB_GTI_CLOSABLE, .F. )   // não permite fechar pelo X
 HB_GtInfo( HB_GTI_RESIZABLE, .F. )  // não permite alterar a tela pelo quadradinho (só funciona no XP)
 
 Set ScoreBoard Off    // usa a linha 0
 SetMode( 25, 85 )     // usa a largura total da tela
 
 Hb_KeyPut( K_ENTER )  // inicia o exemplo no modo widescreen

 Do While LastKey() != 27

  SetColor( "GR+/N" )
  DispBox( 0, 0, MaxRow(), MaxCol() )

  @ 10, 25 Say "1 = WideScreen"
  @ 11, 25 Say "2 = Standard Window"
  @ 12, 25 Say "3 = Full Screen"

  @ 14, 25 Say "Select with 1,2 or 3:" GET nModo Pict "9" Valid nModo > 0 .And. nModo <= 3
  Read

  SetColor( "G+/N" )

  Do Case

   Case nModo = 1  // Modo Janela WideScreen
    HB_GtInfo( HB_GTI_MAXIMIZED, .F. )
    HB_GtInfo( HB_GTI_ISFULLSCREEN, .F. )
    HB_GtInfo( HB_GTI_MAXIMIZED, .T. )
    @ 16, 25 Say Space( 50 )
    @ 16, 25 Say "1 = You are in WideScreen"

   Case nModo = 2  // Modo Janela Normal
    HB_GtInfo( HB_GTI_MAXIMIZED, .F. )
    HB_GtInfo( HB_GTI_ISFULLSCREEN, .F. )
    HB_GtInfo( HB_GTI_FONTSIZE, 26 )
    HB_GtInfo( HB_GTI_FONTWIDTH, 12 )
    /*
      Apenas em caso de alternancia, precisa
      duplicar para restaurar a tela
    */
    HB_GtInfo( HB_GTI_FONTSIZE, 26 )
    HB_GtInfo( HB_GTI_FONTWIDTH, 12 )
    @ 16, 25 Say Space( 50 )
    @ 16, 25 Say "2 = You are in Standard Window"

   Case nModo = 3  // Tela Cheia (Full Screen)
    HB_GtInfo( HB_GTI_MAXIMIZED, .F. )
    HB_GtInfo( HB_GTI_ISFULLSCREEN, .F. )
    HB_GtInfo( HB_GTI_ISFULLSCREEN, .T. )
    @ 16, 25 Say Space( 50 )
    @ 16, 25 Say "3 = You are in Full Screen"

  End Case

 EndDo

Return Nil