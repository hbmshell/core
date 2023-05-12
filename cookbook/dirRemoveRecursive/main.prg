/*
http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=26943&view=unread#unread
*/
PROCEDURE MAIN

    
    if MakeDir("temp") == 0
        ? "Creating temp"
        if MakeDir("temp/subtemp") == 0
            ? "Creating temp/subtemp"
        endif
    endif
    ? "Type any key to delete 'temp/subtemp'"
    Inkey(0)
    
    if hb_DirRemoveAll( "temp" )
        ? "Remove of directory", "temp", "was successfull"
    endif


    RETURN
