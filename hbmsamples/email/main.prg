
PROCEDURE MAIN

    LOCAL cFrom := "vlademirolandim@gmail.com", lResult
    LOCAL cPassword := "xcwblgclzkhccjju"
    LOCAL aAttach := { HB_FnameMerge( hb_cwd() , "teste.txt" ) , "main.prg" }
    LOCAL cTo := "vlademirolandim@gmail.com", cHost := "smtps://smtp.gmail.com", cSubject := "My subject", cText := "Content"
    
    IF VLJ_Email(  cFrom , cPassword, cHost, cTo, cSubject, cText , aAttach , .t. )
        ? "Ok"
    ELSE
        ? "Fail...  :("
    ENDIF
   
RETURN