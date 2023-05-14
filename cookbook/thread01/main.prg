//Thanks Kresin : https://www.kresin.ru/en/hrbfaq_3.html#Doc13_4
FUNCTION Main()
   LOCAL cVar := Space( 20 )
 
   CLEAR SCREEN
 
   IF !hb_mtvm()
      ? "There is no support for multi-threading, clocks will not be seen."
      WAIT
   ELSE
      hb_threadStart( @Show_Time() )
   ENDIF
 
   @ 10, 10 SAY "Enter something:" GET cVar
   READ
   SetPos( 12, 0 )
   alert( "You enter -> [" + cVar + "]" )
   //WAIT
 
   RETURN Nil
 
FUNCTION Show_Time()
   LOCAL cTime
 
   DO WHILE .T.
      cTime := Dtoc( Date() ) + " " + Time()
      hb_dispOutAt( 0, MaxCol() - Len( cTime ) + 1, cTime, "GR+/N" )
      hb_idleSleep( 1 )
   ENDDO
 
   RETURN nil


