////////////////////////////////////////////////////////////////////////////
//
//         Autor: Jose Carlos da Rocha                                                                                              
//          Data: 07/05/2015
//         Email: irochinha@hotmail.com.br
//     Linguagem: xBase / Fivewin
//   Plataformas: DOS, Windows
// Requerimentos: Harbour/xHarbour
// http://www.pctoledo.com.br/forum/viewtopic.php?f=43&t=16101
/////////////////////////////////////////////////////////////////////////////


FUNCTION MAIN()

   //? ;
   //'ShellExecute( "CMD.EXE", "RUNAS", "", "C:\WINDOWS\SYSTEM32", 1 )',,;
   ShellExecute( "CMD.EXE", "RUNAS", "", "C:\WINDOWS\SYSTEM32", 1 )

RETURN .T.

#pragma BEGINDUMP
        #include 
        #include 
        // ShellExecute( cFile, cOperation, cParams, cDir, nFlag )
        HB_FUNC( SHELLEXECUTE )
        {
        hb_retnl( (LONG) ShellExecute( GetActiveWindow(),
                  ISNIL(2) ? NULL : (LPCSTR) hb_parc(2),
                  (LPCSTR) hb_parc(1),
                  ISNIL(3) ? NULL : (LPCSTR) hb_parc(3),
                  ISNIL(4) ? "C:\\" : (LPCSTR) hb_parc(4),
                  ISNIL(5) ? 1 : hb_parni(5) ) ) ;
        }
#pragma ENDDUMP