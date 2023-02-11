
/*
  compilar usando: Hbmk2 exemplo.prg -lhbwin -lxhb
  http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=19039&p=154787&hilit=Raw#p154787
  
*/
Function Main()

cDevOut := GetDefaultPrinter()

? "Send report to ", cDevOut

cIMPX = "NOTA.TXT"

SET PRINTER TO &cIMPX
SET DEVICE TO PRINT

@ PROW()+1,2 SAY "Organization Name"
@ PROW()+1,2 SAY "Department Y"
@ PROW()+1,2 SAY "Date : " + DtoC(Date())
@ PROW()+1,2 SAY "Employee : Billy Paul" 
@ PROW()+1,2 SAY "R.F.C. 123948t-QWE" 
@ PROW()+1,2 SAY "PHONE : 128976-433221"

@ PROW() ,22 SAY DTOC(DATE())+" - "+SUBSTR(TIME(),1,5)
@ PROW()+1, 0 SAY REPLICATE("-",40)

SET DEVICE TO SCREEN
SET PRINTER TO
PRINTFILERAW(cDevOut,cIMPX)

ShellExecute( 'NOTA.TXT', 'Print' )

RETURN NIL