
PROCEDURE Main
LOCAL cTexto := "Depõe do trono os poderosos e exalta os humildes."

    ? cTexto, "Is in UTF8 ?" , hb_StrIsUTF8( cTexto ) 
    ? cOut := hb_translate( cTexto, "UTF8" , "PT850" ), "Is in UTF8 ?" , hb_StrIsUTF8( cOut ) 
       
RETURN 