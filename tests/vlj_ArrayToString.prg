
PROCEDURE MAIN

    MODULE TEST GROUP
    TEST GROUP TITLE "Array -> String"

    TEST GROUP ADD SimpleConversion

    TEST GROUP EXEC

    EndTest()

RETURN
/**
Erase temporary files
*/
STATIC PROCEDURE EndTest()

    
RETURN
/**
Download page
*/
#define NOT_OVERWRITE .f.
BEGIN TEST SimpleConversion TITLE "Simple Conversion"

    LOCAL lReturn, cMessage := "", aArray := { 12 , 14 , 15 , Date() , .t. , "Hello" }
    
    lReturn := ( cMessage := VLJ_ArrayToString( aArray )  == "12;14;15;2022-11-27;.T.;Hello" )
    TEST "Convert " + hb_ValToExp(aArray) EXPECTED .t. RESULT lReturn COMPLEMENT cMessage

    
END TEST
