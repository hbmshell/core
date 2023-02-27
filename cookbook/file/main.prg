
PROCEDURE Main

   LOCAL cFile := "/home/test.dbf"
   	
      // Thanks!                                                                                                                                                         
      // https://vivaclipper.wordpress.com/tag/hb_fnamename/                                                                                                             
      ? "Path : " ,  HB_FNameDir( cFile )
      ? "Extension : " , HB_FNameExt( cFile )
      ? "Single name : " , HB_FNameName( cFile )
      ? "Name + extension : " , HB_FNameNameExt( cFile )

 

    RETURN
