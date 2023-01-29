PROCEDURE Main

    ? " 1st occourence in string " , cString := ";2;3;4", " delimited by ", cDelim := ";", " => " , HB_TokenGet( cString, 1, cDelim ) , " It shows ''"
    ? " 2st occourence in string " , cString := ";2;3;4", " delimited by ", cDelim := ";", " => " , HB_TokenGet( cString, 2, cDelim ) , " It shows '2'"

    ? " 1st occourence in string " , cString := "2*3*4" , " delimited by ", cDelim := "*", " => " , HB_TokenGet( cString, 1, cDelim ) , " It shows '2'"



    RETURN