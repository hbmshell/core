
PROCEDURE MAIN

    LOCAL cString
    LOCAL cKey := "xxx" // Error if replace with "" (Empty string)
    
    cString := "My Password"
    ? hb_crypt( cString , cKey  )
    ? hb_decrypt( hb_crypt( cString , cKey  ) , cKey  )
    ? "Comparing..."
    ? "Decrypt-> ", hb_ValToExp( cString ) , " Crypt-> ", hb_ValToExp( hb_decrypt( hb_crypt( cString , cKey  ) , cKey  ) )
    ? cString == hb_decrypt( hb_crypt( cString , cKey  ) , cKey  )


    RETURN