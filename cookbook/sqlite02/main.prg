
PROCEDURE MAIN

   LOCAL oConn 

   FERASE( "teste.db3" )
   oConn := sqlite_connect( "teste.db3" , .t. ) 
   IF .NOT. EMPTY( oConn ) 
      sqlite_exec( oConn , "CREATE TABLE x ( c1 CHAR(30) )" )
      sqlite_exec( oConn , hb_strFormat("INSERT INTO x ( c1 ) VALUES ( '%s' )", TIME() ) )	
      sqlite_exec( oConn , hb_strFormat("INSERT INTO x ( c1 ) VALUES ( '%s' )", DTOS(DATE()) ) )	
   ELSE
      ? "Database doesn't connected :("
   ENDIF

   RETURN 

FUNCTION sqlite_connect(dbname,lCreate)
   RETURN sqlite3_open(dbname,lCreate)

function sqlite_exec(oConn,query)
   if empty(oConn)
      ? "ERROR: oConn is null (empty)"
      return .f.
   endif
   sqlite3_exec(oConn,query)
   if sqlite3_errcode(oConn) > 0 // error
      ? "Erro SQL : " ,  sqlite3_errmsg( oConn ) 
      return .f.
   endif
return .t.


