
PROCEDURE MAIN

    LOCAL cString

    /* http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=17848 */    
    LOCAL a, b, c, d
    ? hb_StrToHex( a := hb_Crypt( "hello" ) ) // <-------- hb_Crypt without key (second parameter)
    ? hb_StrToHex( b := hb_Crypt( "hello", "" ) )
    ? hb_StrToHex( c := hb_Crypt( "hello", Chr( 0 ) ) )
    ? hb_StrToHex( d := hb_Crypt( "hello", "1" ) )
    ? "------------"
    ? 
    ? a, " ===> ", hb_Decrypt( a ) // ello <-------- hb_Crypt without key (second parameter)
    ? b, " ===> ", hb_Decrypt( b, "" ) // hello
    ? c, " ===> ", hb_Decrypt( c, Chr( 0 ) ) // hello
    ? d, " ===> ", hb_Decrypt( d, "1" ) // hello   
    /***/
    
   
    RETURN