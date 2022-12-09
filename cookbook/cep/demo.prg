#!/workspace/hbmshell/hbmshell --dialog tui
//-q0

FUNCTION hb_Main()
   
   CLS
   @ 07, 05  to 15, 72
   @ 08,07 SAY "CEP........:"
   @ 09,07 SAY "Endereco...:"
   @ 10,07 SAY "Bairro.....:"
   @ 11,07 SAY "Cidade.....:"
   @ 12,07 SAY "Cod.IBGE...:"
   @ 13,07 SAY "Estado.....:"
   @ 14,07 SAY "Complemento:"
   wzendereco:= spac(50)
   wzcidade  := spac(35)
   wzbairro  := spac(30)
   wzcompleme:= spac(40)
   wzcodcid  := spac(9)
   wzestado  := spac(2)
   DO WHILE .T.
      wzcep:=spac(8)
      @ 08,20 GET wzcep  pict '@R 99999-999'
      READ
      oCep := cepWeb( wzCEP )
      IF oCep == NIL
         IF Alert("CEP Invalido... Quer Digitá-lo Novamente ?",{"Sim","Não"}) == 1
            LOOP
         ENDIF
         EXIT
      ENDIF
      wzcep     :=oCep:cCEP
      wzcodcid  :=oCep:cIBGE
      wzendereco:=Left(oCep:cLogradouro+spac(50),50)
      wzcompleme:=Left(oCep:cComplemento+spac(40),40)
      wzbairro  :=Left(oCep:cBairro+spac(30),30)
      wzcidade  :=Left(oCep:cLocalidade+spac(35),35)
      wzestado  :=oCep:cUF
      EXIT
   ENDDO
   @ 09,20 GET wzendereco   pict '@!'
   @ 10,20 GET wzbairro     pict '@!'
   @ 11,20 GET wzcidade     pict '@!'
   @ 12,20 GET wzcodcid     pict '@!'
   @ 13,20 GET wzestado     pict '@!'
   @ 14,20 GET wzcompleme   pict '@!'
   READ

FUNCTION cepWeb( cCEP)

   LOCAL oCEP := ViaCEP():New( cCEP )

   RETURN oCEP

CREATE CLASS ViaCEP

   VAR oCep
   VAR cCep         INIT ''
   VAR cIBGE        INIT ''
   VAR cLogradouro  INIT ''
   VAR cComplemento INIT ''
   VAR cBairro      INIT ''
   VAR cLocalidade  INIT ''
   VAR cUF          INIT ''
   METHOD New( cCEP )
   ENDCLASS

METHOD New( cCEP )

   oHttp := TIPClientHTTP():new( "http://viacep.com.br/ws/" + cCEP + "/piped/" )
   IF ! oHttp:open()
      RETURN NIL
   ENDIF
   cHtml := oHttp:readAll()
   oHttp:close()
   cHtml := HB_UTF8TOSTR( cHtml )
   aHtml := hb_aTokens( cHtml, '|' )
   IF Len( aHtml ) < 7
      RETURN NIL
   ENDIF
   cCEP         := Substr( aHtml[1], AT( ':', aHtml[1] ) + 1 )
   cLogradouro  := Substr( aHtml[2], AT( ':', aHtml[2] ) + 1 )
   cComplemento := Substr( aHtml[3], AT( ':', aHtml[3] ) + 1 )
   cBairro      := Substr( aHtml[4], AT( ':', aHtml[4] ) + 1 )
   cLocalidade  := Substr( aHtml[5], AT( ':', aHtml[5] ) + 1 )
   cUF          := Substr( aHtml[6], AT( ':', aHtml[6] ) + 1 )
   cIBGE        := Substr( aHtml[7], AT( ':', aHtml[7] ) + 1 )
   ::cCEP         := cCEP
   ::cLogradouro  := cLogradouro
   ::cComplemento := cComplemento
   ::cBairro      := cBairro
   ::cLocalidade  := cLocalidade
   ::cUF          := cUF
   ::cIBGE        := cIBGE

   RETURN SELF
