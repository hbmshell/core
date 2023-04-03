
PROCEDURE MAIN

    LOCAL cFrom := "", lResult
    LOCAL cPassword := ""
    LOCAL aAttach := { "./main.prg" , "./main2.prg" }
    LOCAL cTo := "", cHost := "smtps://smtp.gmail.com", cSubject := "My subject", cText := "Content"
    

    //SEND EMAIL FROM cFrom TO cTo SUBJECT cSubject TEXT cText ATTACHMENT aAttach PASSWORD cPassword RESULT TO lResult
    //SEND EMAIL FROM cFrom TO cTo SUBJECT cSubject TEXT cText PASSWORD cPassword 
    VLJ_Email(  cFrom , cPassword, cHost, cTo, cSubject, cText , , .t. )
   
RETURN