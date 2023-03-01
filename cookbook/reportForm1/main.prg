// Shebang line
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main
 
    CreateTest()
    USE test NEW
    REPORT FORM EE
    USE

RETURN

PROCEDURE CreateTest

    LOCAL aStru := {},x

    AADD( aStru, {"ID","N",10,0})
    AADD( aStru, {"DESC","C",50,0})
    AADD( aStru, {"VALUE","N",12,2})
    AADD( aStru, {"STATUS","L",30,0})

    DBCREATE( "test" , aStru )
    USE test
    FOR x := 1 TO 100
        APPEND Blank
        REPLACE ID WITH x
        REPLACE DESC WITH "CLIENT " + Str(x)
        REPLACE VALUE WITH hb_RandInt(1000,10000)
        REPLACE STATUS WITH .T.
    NEXT
    USE

RETURN
