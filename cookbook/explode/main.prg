
PROCEDURE MAIN


    ? HB_VALTOEXP( HB_ATOKENS( " 1 2 3 " ) ) // returns array:  { "1", "2", "3" }

       // Any other delimiters are restrictly counted, f.e.:

    ? HB_VALTOEXP(  HB_ATOKENS( ",,1,,2,") ) // returns array: { "", "", "1", "", "2", "" }

    ? HB_VALTOEXP( HB_ATOKENS( "1;2;3;4;5" , ";" ) ) 


RETURN
