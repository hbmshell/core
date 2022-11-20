
PROCEDURE MAIN

    MODULE TEST GROUP
    TEST GROUP TITLE "Simple Download"

    TEST GROUP ADD DownloadHTTPPage

    TEST GROUP EXEC

    EndTest()

RETURN
/**
Erase temporary files
*/
STATIC PROCEDURE EndTest()

    FErase("www.google.com")

RETURN
/**
Download page
*/
#define NOT_OVERWRITE .f.
BEGIN TEST DownloadHTTPPage TITLE "Download HTTP Page"

    LOCAL lReturn, cMessage := ""
    
    lReturn := vlj_Download( "https://www.google.com" ) 
    TEST "Downloading www.google.com (Pass)" EXPECTED .t. RESULT lReturn COMPLEMENT cMessage

    lReturn := vlj_Download( "https://www.google.com" , NOT_OVERWRITE, /* New file name */ , @cMessage ) 
    TEST "Downloading www.google.com (Fail)" EXPECTED .f. RESULT lReturn COMPLEMENT cMessage

    ? "mensagem", cMessage 

   
END TEST
