// https://en.wikibooks.org/wiki/Clipper_Tutorial:_a_Guide_to_Open_Source_Clipper(s)/Working_With_Databases
/**
Description
-----------
Append from CSV

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main

    LOCAL aDbf := {} 
    AADD(aDbf, { "MOVIEID", "C", 6, 0 })
    AADD(aDbf, { "TITLE", "C", 30, 0 }) 
    AADD(aDbf, { "GENRE", "C", 30, 0 }) 
    AADD(aDbf, { "YEAR", "N", 4, 0 }) 
    AADD(aDbf, { "LEADACTOR", "C", 30, 0 }) 
    AADD(aDbf, { "PRICE_EUR", "N", 5, 2 })
    DBCREATE("videolib", aDbf)
    use videolib 
    Append From movies.txt delimited
    go top
    Browse(10,5,50,70)

RETURN
