/*
http://www.fivetechsoft.com/harbour-docs/api.html#dirremove
*/
PROCEDURE MAIN

    
    if MakeDir("temp") == 0
        ? "Creating temp"
    endif
    ? "Type any key to delete 'temp'"
    Inkey(0)
    
    if DIRREMOVE( "temp" ) == 0
        ? "Remove of directory", "temp", "was successfull"
    endif


    RETURN
