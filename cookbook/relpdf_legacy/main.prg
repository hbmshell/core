#include "pdf.ch"
#include "inkey.ch"
//////////////////////////////////////////////////////
// OBS
// ESSE ARQUIVO USA FONTS.DAT (NAO ESQUECA !!!)
//////////////////////////////////////////////////////
//memvar aReport
static aReport  

PROCEDURE MAIN

    ? "Generating " , relpdf( "texto.txt" , 1 )

RETURN

Function RetiraASCString( lc_linha )
Local xASC

      FOR xASC := 0 TO 31
          lc_linha := STRTRAN( lc_linha , CHR(xASC) , "" )
      NEXT
      lc_linha := STRTRAN( lc_linha , CHR(127) , "" )

Return lc_linha

#include "relpdf.prg"


