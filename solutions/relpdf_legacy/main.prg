
PROCEDURE MAIN

    relpdf( "texto" , 1 )

RETURN

Function RetiraASCString( lc_linha )
Local xASC

      FOR xASC := 0 TO 31
          lc_linha := STRTRAN( lc_linha , CHR(xASC) , "" )
      NEXT
      lc_linha := STRTRAN( lc_linha , CHR(127) , "" )

Return lc_linha


