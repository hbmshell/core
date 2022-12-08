
procedure main

   cCode := 'http://www.pctoledo.com.br/forum/posting.php?mode=reply&f=4&t=26626'
   nFlags := 0

   // \contrib\hbzebra
   hBitmap := hb_zebra_create_qrcode( cCode, nFlags )
   
     ? "Pointer          :", hb_ValToExp( hBitmap )


   // \contrib\hbfhBitmapage
   fi_Save( FIF_BMP, hBitmap, hb_PathJoin( 'C:\Users\vlade\Documents\GitHub\core\cookbook\QRCode2Image','file.bmp'), BMP_DEFAULT  )
   
   return