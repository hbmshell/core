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
    
    MySample() // Generate movies.txt 
    
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

Procedure MySample
local cVar := ""

cVar += '1,"Jurassic Park","azione",1993,"Jeff Goldblum",35.99'+hb_eol()
cVar += '2,"Jumanji","avventura",1995,"Robin Williams",8.49'+hb_eol() 
cVar += '3,"Navigator","fantascienza",1986,"Joey Cramer",11.39'+hb_eol() 
cVar += '4,"Mortal Kombat","azione",1995,"Christopher Lambert",10'+hb_eol() 
cVar += '5,"Karate Kid 4","azione",1994,"Hilary Swank",4.9'+hb_eol() 
cVar += '6,"Ritorno al futuro","fantascienza",1985,"Michael J. Fox",6.95'+hb_eol() 
cVar += '7,"2001: Odissea nello Spazio","fantascienza",1968,"Keir Dullea",7.9'+hb_eol() 
cVar += '8,"Il pianeta proibito","fantascienza",1956,"Leslie Nielsen",9.99'+hb_eol() 
cVar += '9,"Interstellar","fantascienza",2014,"Matthew McConaughey",6.95'+hb_eol()
cVar += '10,"Prometheus","fantascienza",2012,"Michael Fassbender",7'+hb_eol()


hb_memowrit( "movies.txt", cVar )


RETURN