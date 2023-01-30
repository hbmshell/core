
PROCEDURE MAIN
   LOCAL dbname := "teste.db3", lCreate := .t.
   LOCAL oServerSQLite := sqlite3_open(dbname,lCreate)

   FERASE( "teste.db3" )	
   
   IF .NOT. Empty( oServerSQLite )
      ? "Database connect was made successfully!"
   ELSE
      ? "Database doesn't connected :("
   ENDIF

   RETURN 

