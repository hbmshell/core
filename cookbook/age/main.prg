// Thanks J.M.Quintas
PROCEDURE MAIN

    LOCAL dDataNasc := STOD("19990515")
    ? Date() , " - " , dDataNasc
    ? Idade( dDataNasc, Date() )
    
RETURN

FUNCTION Idade( dDataNasc, dDataCalc )

   LOCAL nDias, nMeses, nAnos

   hb_Default( @dDataCalc, Date() )
   IF Empty( dDataNasc ) 
      RETURN "*Undefined*"
   ENDIF
   nAnos := Year( dDataCalc ) - Year( dDataNasc )
   IF Substr( Dtos( dDataCalc ), 5 ) < Substr( Dtos( dDataNasc ), 5 )
      nAnos := nAnos - 1
   ENDIF
   nMeses := ( 12 - Month( dDataNasc ) ) + Month( dDataCalc )
   DO CASE
   CASE Day( dDataCalc ) = Day( dDataNasc )
      nDias := 0
   CASE Day( dDataCalc ) < Day( dDataNasc )
      nMeses := nMeses - 1
      nDias  := Day( Last_Day( dDataNasc ) ) - Day( dDataNasc ) + Day( dDataCalc )
   OTHERWISE
      nDias := Day( dDataCalc ) - Day( dDataNasc )
   ENDCASE
   nMeses = Mod( nMeses, 12 )

   RETURN LTrim( Str( nAnos, 3 ) ) + " year(s), " + LTrim( Str( nMeses, 3 ) ) + " month(s), " + LTrim( Str( nDias, 3 ) ) + " day(s)"

FUNCTION Last_Day( dData )

   dData += ( 40 - Day( dData ) )
   dData -= Day( dData )

   RETURN dData
