//http://www.pctoledo.com.br/forum/viewtopic.php?f=43&t=16232
PROCEDURE Main
   LOCAL cIp := "localhost"
   LOCAL nPort := 3306
   LOCAL cDatabase := "biblia"
   LOCAL cUser := "root"
   LOCAL cPassword := ""
   LOCAL oConexao := MariaConnection( cIP, nPort, cDatabase, cUser, cPassword )
   oConexao:Open()
   oRs := oConexao:Execute( "SELECT liv_nome FROM livros" )
   DO WHILE .NOT. oRs:Eof()
       ? oRs:Fields( "liv_nome" ):Value
       oRs:MoveNext()
    ENDDO
    oRs:Close()
   oConexao:Close()
   RETURN
/*
Open Connection
*/
FUNCTION MariaConnection( cServer, nPort, cDatabase, cUser, cPassword )
   LOCAL cnConnection
   cnConnection:= win_OleCreateObject( "ADODB.Connection" )
   cnConnection:ConnectionString := "Driver={MariaDB ODBC 3.1 Driver};Server=" + cServer + ";" + "Port=" + Ltrim( Str( nPort ) ) + ;
      ";Stmt=;Database=" + cDatabase + ";User ID=" + cUser + ";Password=" + cPassword 
   cnConnection:CursorLocation    := adUseClient   // local recordset
   cnConnection:CommandTimeOut    := 120 // seconds
   cnConnection:ConnectionTimeOut := 120 // seconds
   RETURN cnConnection