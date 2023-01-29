
PROCEDURE MAIN

    LOCAL hIni := { => }

    /* http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=19428 */    
    /* https://searchcode.com/codesearch/view/4503902/ */
    
    hIni["BANCO01"] := { => }
    hIni["BANCO01"]["USUARIO"] := "USER01"
    hIni["BANCO01"]["PASSWORD"] := "PASS"
    hb_IniWrite( "test.ini" , hIni )    
    
    ? hb_MemoRead( "test.ini" )

    RETURN
    
    