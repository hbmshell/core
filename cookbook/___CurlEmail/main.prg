//#include "hbcurl.ch"
PROCEDURE MAIN

    LOCAL cFrom , cPassword, cHost, cTo, cSubject, cText , aAnexos, lDebug, lBodyHTML
    LOCAL lReturn := .t. 
    //LOCAL cHtml // To content HTML (not used in this  example)
    LOCAL lSTARTTLS_force := .t.
    LOCAL curl
    LOCAL lSystemCA := .f.
    LOCAL cDate := "Tue, " + hb_ntos(Day(Date())) +" Feb " + hb_ntos(Year(Date())) + " " + TIME()
    LOCAL cUser
    
    LOCAL cCa := "cacert.pem"
    CLS
    
    cFrom := "hbmshell@gmail.com" + SPACE(20)
    cPassword := "lklçl"
    cHost := "smtps://smtp.gmail.com"
    cTo := "destino@gmail.com"
    cSubject := "God News!"
    cText := "Atenção !" + hb_eol()
    cText += hb_eol()
    cText += "Hora de verificar os backups"
    
    lDebug := .f.
    aAnexos := {}
    lBodyHTML := .f.

    //--------------- Begin 
    

    IF lDebug
        ? cCA, " <<<<<<<<<<<<<<<<<<<<<<< "
    ENDIF
     
    cFrom := "<" + ( cUser := hb_curl_mail_address_to_email( cFrom ) ) + ">"
    IF lDebug
        ? "From : " , cFrom
    ENDIF
    cTo := "<" + hb_curl_mail_address_to_email( cTo ) + ">"
    IF lDebug
        ? "Send e-mail to   : " , cTo
        ? "Host:", cHost, iif( lSTARTTLS_force, "(must STARTTLS)", "" )
        ? "User:", cUser
    ENDIF
     curl_global_init()
   
    IF Empty( curl := curl_easy_init() )
         IF lDebug
            ? "Failed to init"
         ENDIF
        Return .f.
    ENDIF

    IF ! lSystemCA                                         

        IF ExtractCURLCertificate( cCA ) // Extrai o certificado 
              curl_easy_setopt( curl, HB_CURLOPT_CAINFO, cCA )
        ELSE
            IF lDebug
              ?
              ? "Error: Trusted Root Certificates missing. Open this URL in your web browser:"
              ? "  " + "https://curl.haxx.se/ca/cacert.pem"
              ? "and save the file as:"
              ? "  " + cCA
            ENDIF  
            RETURN .f.
         ENDIF
    ENDIF

     curl_easy_setopt( curl, HB_CURLOPT_USE_SSL, ;
        iif( lSTARTTLS_force, HB_CURLUSESSL_ALL, HB_CURLUSESSL_TRY ) )
     curl_easy_setopt( curl, HB_CURLOPT_UPLOAD )
     curl_easy_setopt( curl, HB_CURLOPT_URL, cHost )
     curl_easy_setopt( curl, HB_CURLOPT_PROTOCOLS, ;
        hb_bitOr( HB_CURLPROTO_SMTPS, HB_CURLPROTO_SMTP ) )
     curl_easy_setopt( curl, HB_CURLOPT_TIMEOUT_MS, 15000 )
     curl_easy_setopt( curl, HB_CURLOPT_VERBOSE, .T. )
     curl_easy_setopt( curl, HB_CURLOPT_USERNAME, cUser )
     curl_easy_setopt( curl, HB_CURLOPT_PASSWORD, cPassword )
     curl_easy_setopt( curl, HB_CURLOPT_MAIL_FROM, cFrom )
     curl_easy_setopt( curl, HB_CURLOPT_MAIL_RCPT, { cTo } )


    // ENviado por hbcurl
    curl_easy_setopt( curl, HB_CURLOPT_HTTPHEADER, { ;
           "Date: " + cDate, ;
           "To: " + cTo, ;
           "From: " + "naoresponda" + cFrom, ;
           "Cc: " + cTo, ;
           "Message-ID: <dcd7cb36-11db-487a-9f3a-e652a9458efd@rfcpedant.example.org>", ;
           "Reply-To: " + cFrom, ;
           "Disposition-Notification-To: " + cFrom, ;
           "X-Priority: " + hb_ntos( 3 ), ;  /* 1: high, 3: standard, 5: low */
           "Subject: " + cSubject } )


    cText := tip_MailAssemble( ;
             cFrom, ;
             { cTo }, ;
             /* aCC */, ;
             cText, ;
             cSubject, ;
             aAnexos  /* attachments */, ;
             /* nPriority */, ;
             /* lRead */, ;
             /* cReplyTo */, ;
             /* cCharset */, ;
             /* cEncoding */, ;
             lBodyHTML, ;
             /* bSMIME */ )
             
    curl_easy_setopt( curl, HB_CURLOPT_UL_BUFF_SETUP, cText )
    
    curl_easy_setopt( curl, HB_CURLOPT_INFILESIZE_LARGE, hb_BLen( cText ) )   

    IF lDebug
        ? "Result:", curl_easy_perform( curl )
    ELSE
        curl_easy_perform( curl )    
    ENDIF

    curl_easy_cleanup( curl )


RETURN lReturn


STATIC FUNCTION hb_curl_mail_address_to_email( cAddress )

    LOCAL tmp, tmp1
  
    IF ( tmp := At( "<", cAddress ) ) > 0 .AND. ;
       ( tmp1 := hb_At( ">", cAddress, tmp + 1 ) ) > 0
       RETURN AllTrim( SubStr( cAddress, tmp + 1, tmp1 - tmp - 1 ) )
    ENDIF
  
    RETURN cAddress
/*  
STATIC  FUNCTION hb_curl_mail_address_to_name( cAddress )
  
    LOCAL tmp
  
    IF ( tmp := At( "<", cAddress ) ) > 0 .AND. ;
       hb_At( ">", cAddress, tmp + 1 ) > 0
       RETURN RTrim( Left( cAddress, tmp - 1 ) )
    ENDIF
  
    RETURN cAddress
*/
STATIC FUNCTION ExtractCURLCertificate( cFile )

    LOCAL cCertificateContent 
    LOCAL lRetu := .t.


    hb_Default( @cFile , hb_PathJoin( hb_cwd(), "cacert.pem" )  )
    IF .NOT. FILE( cFile )
        // Extrai o certificado
        #pragma __binarystreaminclude "cacert.pem" | cCertificateContent := %s
        IF hb_MemoWrit( cFile , cCertificateContent )
        ELSE
            ? "Can't save certificate ", cFile
            lRetu := .f.
        ENDIF
    ENDIF

RETURN lRetu 

*/
