
    #require "hbzebra"
    #require "hbfimage"
PROCEDURE MAIN


   cCode := 'http://www.pctoledo.com.br/forum/posting.php?mode=reply&f=4&t=26626'
   nFlags := 0

   // \contrib\hbzebra
   hBitmap := hb_zebra_create_qrcode( cCode, nFlags )

   // \contrib\hbfimage
? "KKKKKKKKKKKKKK"
   ? ">>>>" , hb_valtoexp( fi_Save( FIF_BMP, hBitmap, 'file.bmp', BMP_DEFAULT  ) )

RETURN