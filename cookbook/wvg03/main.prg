//http://www.elektrosoft.it/tutorials/gtwvg/gtwvg.asp
PROCEDURE Main()

	LOCAL cF1, cF2, cF3
	LOCAL GETLIST := {}
 
	Wvt_SetGui( .T. )
 
	SetMode( 25, 80 )
	SetColor( "N/W" )
	CLS
 
	Wvt_SetTitle( "Giovanni's Window" )
 
	SetColor( "N/W,N/GR*,,,N/W*" )
 
	cF1 = Space( 30 )
	cF2 = Space( 30 )
	cF3 = Space( 30 )
 
	@ 08, 10 SAY "Enter field 1  " GET cF1
	@ 10, 10 SAY "Enter field 2  " GET cF2
	@ 12, 10 SAY "Enter field 3  " GET cF3
 
	READ
 
	RETURN
 





