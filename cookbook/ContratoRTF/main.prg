* Thanks Hasse : http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=14160
*
*==================================================================================================
FUNCTION Main()                                 //  PRT_CBSUL()
*
SET DATE FORMAT TO "DD/MM/YYYY"
SET EPOCH TO 1901
*
REQUEST HB_CODEPAGE_PT850
HB_SetCodePage( "PT850" )
*
REQUEST DBFCDX
RddSetDefault("DBFCDX")
*
c_Arq1 := "_Contrato_CBSUL_01.rtf"                                        // c_ServPath + "\_Contrato_CBSUL_01.rtf"
c_Arq2 := "_Contr_CBSUL.rtf"                                              // c_LocalPath + "\_Contr_CBSUL.rtf"
c_Data := DtoC( Date() )
*
IF File( c_Arq1 )
   FileCopy( c_Arq1, c_Arq2 )
   SetFAttr( c_Arq2, 0 )
   c_Contrato := MemoRead( "_Contrato_CBSUL_01.rtf" )
ELSE
   Alert( 'O arquivo "_Contr_CBSUL.rtf" est  faltando no servidor. ;;Verifique !!!;;' +;
          'Impressão cancelada.')
   RETURN( NIL )
ENDIF
*
c_NomDev  := "Edson Machado da Silva Borges Medina"               // ALLTRIM( CADASTRO->NOME )
c_CpfCnpj := "111.222.333/0001-44"                                // ALLTRIM( CADASTRO->CGC_CPF )
c_Ident   := "5.666.777-8"                                        // ALLTRIM( CADASTRO->IDENT )
*
IF EMPTY( c_CpfCnpj )
   ALERT( 'Falta o CPF/CNPJ do cliente ;== ' + c_NomDev + ' ==;Providenciar;;Emissão do Contrato Cancelado.' )
   RETURN( .F. )
ENDIF
*
IF EMPTY( c_Ident ) .AND. "CPF-" $ c_CpfCnpj
   ALERT( 'Falta a IDENTIDADE do cliente ;== ' + c_NomDev + ' ==;  Providenciar;;Emissão do Contrato Cancelado.' )
   RETURN( .F. )
ENDIF
*
c_NomDev   := HB_OemToAnsi( c_NomDev )
c_CpfCnpj  := STRTRAN( c_CpfCnpj, "CPF-", "" )
*
c_Contrato := STRTRAN( c_Contrato, "#@NomDev@#",    c_NomDev )
c_Contrato := STRTRAN( c_Contrato, "#@NumCPF@#",    c_CpfCnpj )
c_Contrato := STRTRAN( c_Contrato, "#@NumIdent@#",  c_Ident )
c_Contrato := STRTRAN( c_Contrato, "#@DtContr@#",   c_Data )
*
MemoWrit( "_Contr_CBSUL.rtf", c_Contrato )
*
cRoda2 := 'START _Contr_CBSUL.rtf'
*
RUN( cRoda2 )
*
RETURN( NIL )