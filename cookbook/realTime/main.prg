// http://www.elektrosoft.it/tutorials/harbour-how-to/harbour-how-to.asp#time
/**
Description
-----------
Display real time clock in screen

hbmk2
-----
hbmk2 test.prg xhb.hbc
*/

PROCEDURE main()

    LOCAL cName, cSurname
    LOCAL GetList := {}
 
    SetMode( 25, 80 )
    cls
 
    ShowTime( 1, 70, .F. , "rg+/g" )
 
    cName = Space( 20 )
    cSurname = Space( 20 )
 
    @ 10, 10 SAY "Name     " GET cName
    @ 12, 10 SAY "Surname  " GET cSurname
 
    READ
 
    ShowTime()
 
    RETURN
