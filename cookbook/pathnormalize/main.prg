/**
To build
--------

hbmk2 main.prg 

Thanks!
https://vivaclipper.wordpress.com/2014/03/03/hb_pathnormalize/

*/
PROCEDURE Main
   
   LOCAL cDir := '.'
   ? HB_PathNormalize( cDir  ) // fail
   ? HB_PathNormalize( cDir + "\.." ) // fail
   cDir := hb_cwd()
   ? HB_PathNormalize( cDir + "\.." ) // works
   cDir := hb_dirtemp()
   ? HB_PathNormalize( cDir + "\.." ) // works
RETURN


