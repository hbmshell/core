//http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=16826&start=30
REQUEST HB_MEMIO 
REQUEST DBFCDX
PROCEDURE MAIN

    LOCAL aStr := {} 

    AADD( aStr, { "COD" , "C" , 10 , 0 } )
    AADD( aStr, { "NAME" , "C" , 100 , 0 } )
    AADD( aStr, { "SALARY" , "N" , 12 , 2 } )

    dbCreate( "teste", aStr )

    //---Begin
    use teste via "DBFCDX"
    index on name to teste
    aStruct := dbStruct()
    close
    nSeg := Int(Seconds()*100)
    cFileDbf := "mem:TMP"+Right(StrZero(nSeg),5)+".DBF"
    dbCreate(cFileDbf, aStruct,"DBFCDX",.T.)
    cFileCdx := "mem:TMP"+Right(StrZero(nSeg+1),5)+".CDX"
    index on salary to ( cFileCdx ) desc
    FOR X := 1 to 100
        Append Blank
        REPLACE COD WITH STRZERO(x,3)
        REPLACE NAME WITH "USER " + FIELD->COD
        REPLACE SALARY WITH 100+X
    NEXT
    go top
    BROWSE()

RETURN