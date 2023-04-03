
PROCEDURE Main


    ? "Creating file x.txt"
    IF hb_MemoWrit( "x.txt" , "Content file" )
        ? "Ok"
    ENDIF
    ? "Type any key to delete x.txt"
    INKEY(0)
    ? Ferase("x.txt")
    IF FILE("x.txt")
        ? "Failed"
    ELSE
        ? "Ok"
    ENDIF



    RETURN
