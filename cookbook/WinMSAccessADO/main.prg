REQUEST HB_CODEPAGE_PTISO

PROCEDURE MAIN()


   LOCAL oCn, cSql
   LOCAL cDatabase := "sistemas33.mdb"
   LOCAL cDb := "DBQ="+ hb_FNameMerge( "C:\" + CurDir(), cDataBase ) + ";Driver={Microsoft Access Driver (*.mdb)}"
   LOCAL oError
   
   ? hb_FNameMerge( "C:\" + CurDir(), cDataBase )

   oCn := win_oleCreateObject( "ADODB.Connection" )
   oCn:ConnectionString := cDb
   oCn:Open()
   //cSql := "INSERT INTO UNKNOW_TABLE ( empno, ename ) VALUES ( 122 , 'NOVO NOME' )"  // <-- Error to test
   cSql := "INSERT INTO emp ( empno, ename ) VALUES ( 122 , 'Exemplo 00' )"  
   
   ? "Execute : " , cSQL 
   BEGIN SEQUENCE WITH __breakblock()
       oCn:Execute( cSql )
   RECOVER USING oError
        ? oError:Description
   ENDSEQUENCE    
   oCn:Close()
   
   RETURN