Procedure Main

? conectado() //"Hello"

Return


FUNCTION conectado(nProvedor)
         LOCAL cnConnection
         LOCAL nPort :=" "
         LOCAL nVersion :=3
         LOCAL cServer :="192.168.15.12"
         LOCAL cDatabase :="blblia"
         LOCAL cUser :="root"
         LOCAL cPassword :=""
         private nVzexq :=0
   
   
   #define AD_USE_CLIENT                    3

   hb_Default( @nPort, 3306 )
   hb_Default( @nVersion, 3 )
   
   do while .t.
      ODBC_MARIADB="Driver={MariaDB ODBC 3.0 Driver};"

      cnConnection:= win_OleCreateObject( "ADODB.Connection" )
         cnConnection:ConnectionString := ODBC_MARIADB + ";Server=" + cServer + ";" + "Port=" + Ltrim( Str( nPort ) ) + ;
         ";Stmt=;Database=" + cDatabase + ";User=" + cUser + ";Password=" + cPassword + ";Collation=latin1;" + ;
         "AUTO_RECONNECT=1;COMPRESSED_PROTO=0;PAD_SPACE=1" // usando compacta╬Æo impede certas checagens // Option=131072;
      cnConnection:CursorLocation    := AD_USE_CLIENT
      cnConnection:CommandTimeOut    := 300 // seconds
      cnConnection:ConnectionTimeOut := 300 // seconds

      if cnConnection:State#0
        exit
     else
        nVzexq++
       if nVzexq>2
          ?"Não conectou"
         inkey(5)
         return 999
        endif
     endif
exit     
   enddo
RETURN cnConnection:State
