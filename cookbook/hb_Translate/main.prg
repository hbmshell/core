REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850

PROCEDURE MAIN

    hb_cdpselect( "PT850" )
    cTexto := hb_MemoRead( "teste.xml" )

    ? cTexto
    ? "Convertendo"
    ? HB_TRANSLATE( cTexto , "UTF8" , "PT850" )


RETURN

