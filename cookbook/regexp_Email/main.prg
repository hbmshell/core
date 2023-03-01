

// The example uses a regular expression to detect if a character
// string is a valid eMail address.

PROCEDURE Main

    Local cRegEx := "\b[!#\$%&'\*\+\-/=\?\^_`{\|}~a-zA-Z0-9][!#\$%&'\*\+\-/=\?\^_`{\|}~a-zA-Z0-9\.]*[!#\$%&'\*\+\-/=\?\^_`{\|}~a-zA-Z0-9]@[a-zA-Z0-9\-][a-zA-Z0-9\-\.]+[a-zA-Z0-9\-]\b"
    LOCAL cEMail, GetList := {}

    SetMode( 24,80)

    CLS

    cEmail := Space( 250 )

    

    @ 10, 10 Say "E-mail address:" Get cEmail PICT "@S30"
    READ

    IF HB_REGEXLIKE( cRegEx, RTrim(cEMail) )
        alert( alltrim( cEMail ) + " ==> valid" ) 
    ELSE
        alert( alltrim( cEMail ) + " ==> invalid" ) 
    ENDIF

 RETURN


    
  