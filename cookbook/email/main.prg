
PROCEDURE MAIN

    LOCAL cFrom := PADL("hbmshell@gmail.com",30)
    LOCAL cPassword := "sdaxamnhecvdaeny"
    LOCAL cTo := SPACE, cHost := "gmail   ", cSubject, cText, cHtml 
    LOCAL GetList

    // VLJ_EMail( cFrom, cPassword, cTo, cHost , cSubject , cText , cHTML )
#ifdef __PLATFORM__WINDOWS
    SetMode( 40, 120  )
#endif
    CLS
    @ 07, 05  to 15, 72
    @ 08,07 SAY "From.......:" GET cFrom 
    @ 09,07 SAY "Password...:" GET cPassword
    @ 10,07 SAY "To.........:" GET cTo
    @ 11,07 SAY "Host.......:" GET cHost
    @ 12,07 SAY "Subject....:" GET cSubject
    @ 13,07 SAY "Text.......:" GET cText
    @ 14,07 SAY "HTML:"

    VLJ_Email( "hbmshell@gmail.com"  )

RETURN