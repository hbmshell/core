
EXTERNAL QOUT
FUNCTION Main()
Local buf, cBuf := "", oErr

   hb_CdpSelect("UTF8")

   cBuf := hb_Memoread("main22.prg")
   VLJ_OutStd( ProcName() )
   VLJ_OutStd( "Before:" )
   buf := hb_compileFrombuf( cBuf , "/n" )

   VLJ_OutStd( "Executing:",  hb_HrbRun( buf ) )

   VLJ_OutStd( )
   VLJ_OutStd( "------------------------------------------------------------" )
   VLJ_OutStd( "Function Main2 is in memory ? " , Type( "Main2()" )=="UI" )

Return Nil
