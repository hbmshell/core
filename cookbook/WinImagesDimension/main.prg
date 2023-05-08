/*
   Test.prg
   Get image dimensions in pixels.
*/

// Thanks : http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=26377
#define imageIn "bmp_13.png"

procedure Main

   local Height, Width

   request DBFNTX                       // Utilisation de fichiers .dbf avec des index .ntx
   set( _SET_DATEFORMAT, "DD/MM/YYYY" ) // Affichage de l'année sur 4 chiffres.
   set( _SET_EOF, .F. )                 // Pas de  à la fin des fichiers créés avec set alte.
   set exact on                         // Pas d'approximation dans la comparaison des chaînes de caractères.

   // ANSI ( Windows ) and french language.
   request HB_LANG_FR
   request HB_CODEPAGE_FRWIN
   hb_cdpSelect( 'FRWIN' )
   hb_langSelect( 'FR' )

   // Taille de la console.
   setmode( 43, 80 )
   setcolor( "GR+/B" )
   @ 0, 0, maxrow(), maxcol() box space( 9 )
   setcolor( "W/B" )

   Height := 0
   Width  := 0
   GetImageHeightWidth( imageIn, @Height, @Width )

   ? "File   : " + imageIn
   ? "Height : " + hb_ntos( Height )
   ? "Width  : " + hb_ntos( Width )
   ?
   wait
   return

procedure GetImageHeightWidth( cFile, nHeight, nWidth )
   local Img1
   img1 := win_oleCreateObject( "WIA.ImageFile" )
   img1:LoadFile( cFile )
   nHeight := img1:Height
   nWidth  := img1:Width
   img1    := nil
   return