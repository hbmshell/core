******************************************************************************
* TESTE.PRG - SISTEMA DE CONTAS A PAGAR.                                     *
*                                                                            *
* ARAGUARI-MG, 01/01/2004. DATA DA ULTIMA ALTERACAO: 28/06/2004.             *
*                                                                            *
* JANIS PETERS GRANTS                                                        *
******************************************************************************

*
* # include "SET.CH"
* # include "INKEY.CH"
* # include "FILEIO.CH"
*

FUNCTION Main()
   *
   SETCANCEL(.F.)          && CANCELA  - PROTECAO DE ARQUIVOS
   SET BELL       OFF                                                              
   SET CENTURY    ON       && OFF ANO=02 DIGITOS(97) ... ON ANO=04 DIGITOS(1997)  
   SET CURSOR     OFF                                                              
   SET DATE       BRITISH  && DATAS COM FORMATO DIA/MES/ANO                       
   SET DELETED    ON       && NAO MOSTRA REGISTROS MARCADOS PARA EXCLUSAO.        
   SET DELIMITERS OFF                                                              
   SET DELIMITERS TO "||"                                                          
   SET ESCAPE     OFF                                                              
   SET EXACT      ON       && CHAVES PARA PESQUISA DEVERAO SER COMPLETAS.         
   SET EXCLUSIVE  OFF      && ARQUIVOS COMPARTILHADOS ...                         
   SET HEADING    OFF                                                              
   SET INTENSITY  OFF      && ON - NECESSARIO PARA MENUS COM BARRAS "PROMPT"
   SET MESSAGE TO 24 CENTER                                                        
   SET SAFETY     OFF                                                              
   SET SCOREBOARD OFF                                                              
   SET STATUS     OFF                                                              
   SET TALK OFF                                                                    
   SET WRAP       ON       && PERMITE "ROLAGEM" DOS PROMPTS NOS MENUS.            
   *******************************************************************************
   PRIVATE cSistema := "*** SISTEMA DE CONTAS A PAGAR ***"
   PRIVATE cLogin   := SPACE(10)
   PRIVATE cSenha   := SPACE(10)
   PRIVATE cConfirma
   *******************************************************************************
   PRIVATE cCor0 := ""
   PRIVATE cCor1 := "BG/B               "
   PRIVATE cCor2 := "+W/B               "
   PRIVATE cCor3 := "+W/B               "
   PRIVATE cCor4 := "+GR*/B             "
   PRIVATE cCor5 := "+GR*/R             "
   PRIVATE cCor6 := "+BG/B,+GR/R,N,,+W/B"
   PRIVATE cCor7 := "+BG/B,+GR/R,,N,,,, "
   *******************************************************************************
   *
   CLEAR
   *
   Tela()
   *
   WHILE .T.
      cConfirma := "N"
      SETCOLOR(cCor4)
      Centro(24,"*** DIGITE OS DADOS CORRETAMENTE ***")
      SETCOLOR(cCor3)
      @ 11,38 SAY cLogin PICTURE '@!'
      @ 13,38 SAY cSenha PICTURE '@!'
      SETCOLOR(cCor2)
      @ 11,38 GET cLogin PICTURE '@!'
        READ
      SET DELIMITERS ON
      @ 13,37 GET cSenha PICTURE '@!'
        READ
      SET DELIMITERS OFF
      SETCOLOR(cCor3)
      Centro(24,"DADOS CORRETOS  (S/N)? ")
      Confirma(24,COL(),@cConfirma)
      IF cConfirma == "S"
         QUIT
      END
   END  && WHILE .T.
   *
RETURN NIL
***

*** PROCEDURE para Centralizar Texto no Video ***
PROCEDURE Centro(nL,cMsg)
IF (VALTYPE(nL) <> "N") .OR. (nL == NIL)
   nL := 24
END
IF (VALTYPE(cMsg) <> "C") .OR. (cMsg == NIL)
   cMsg := "*** ERRO NA MENSAGEM ***"
END
LimpaLinha(nL)
@ nL,(1+INT(78-LEN(ALLTRIM(cMsg)))/2) SAY cMsg
RETURN
***

*** PROCEDURE para Confirmar Perguntas ***
PROCEDURE Confirma(nL,nC,cConfirma)
* HoraData()
SETCOLOR(cCor3)
SET DELIMITERS ON
* SET INTENSITY OFF
@ nL,nC GET cConfirma PICTURE '!' VALID (cConfirma $ "SNC")
READ
* SET INTENSITY ON
LimpaLinha(nL)
SET DELIMITERS OFF
SETCOLOR(cCor0)
RETURN
***

*** PROCEDURE para Limpar Linha ***
PROCEDURE LimpaLinha(nL)
LOCAL cCor := Set(_SET_COLOR)
IF (VALTYPE(nL) <> "N") .OR. (nL == NIL)
   nL := 24  && 23
END
SETCOLOR(cCor1)
IF nL == 24  && 23
   * @ nL,01 SAY SPACE(78)
     @ nL,00 SAY REPLICATE(SPACE(01),80)
ELSE
   @ nL,02 SAY SPACE(76)
END
Set(_SET_COLOR,cCor)
RETURN
***

STATIC PROCEDURE Tela()
*
* TESTE.WW : Arquivo de Lay-Out de Tela 
*
* Criado por JANIS PETERS GRANTS em June 28, 2004
*
SETCOLOR(cCor1)
@ 09,28 SAY "ษอออออออออออออออออออออป"
@ 10,28 SAY "บ ฺฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟ บ"
@ 11,28 SAY "บ ณLogin ณ1234567890ณ บ"
@ 12,28 SAY "บ ภฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤู บ"
@ 13,28 SAY "บ  Senha |1234567890| บ"
@ 14,28 SAY "ศอออออออออออออออออออออผ"
SETCOLOR(cCor0)
RETURN
***

******************************************************************************


