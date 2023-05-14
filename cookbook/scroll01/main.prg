
#include "inkey.ch"
PROCEDURE main( ... )

LOCAL cLine := "Insert any text and type enter" + space(1000)

    n := 1
    DO WHILE .T.
       @ 20,0 GET cLine COLOR "W/N"
       READ
       cLine := space(1000)
       SCROLL(0, 0, 20, MaxCol(), n)
       IF LASTKEY()==K_ESC
           EXIT
       ENDIF

    ENDDO

RETURN


