//Thanks Mauricio Portela : http://www.pctoledo.com.br/forum/viewtopic.php?f=43&t=26946&p=160288&hilit=chr#p160288
#include "inkey.ch"

FUNCTION Main()
    LOCAL cNome
    cls
    @ 02, 02 SAY "Exemplo de Vericacao de Criterio para o Texto com Cifragem"
    @ 03, 02 SAY "(ESC = Sair)"
    @ 04, 02 SAY "Digite um Nome com pelo menos:"
    @ 05, 02 SAY "* uma letra maiuscula;"
    @ 06, 02 SAY "* uma letra minuscula;"
    @ 07, 02 SAY "* um digito"
    @ 08, 02 SAY "* um caractere especial (@#_-+=/*)"
    
    WHILE .t.
        @ 09, 02, 23, 79 BOX SPACE(9)
        cNome := SPACE(15)
        @ 12, 10 say "Digite um Nome :" GET cNome
        READ
        IF LASTKEY() == K_ESC
            EXIT
        ENDIF
        if !VerificaCriterioTexto(cNome)
            // Se nao antender, sair ...
            ALERT("O nome informado nao preenche os requisitos!")
            @ 23, 00
            return -1
        endif
        cNome := CifraDados(cNome)
        @ 14, 10 SAY "Nome Cifrado   : " + cNome
        cNome := DecifraDados(cNome)
        @ 16, 10 SAY "Retorno do Nome: " + cNome
        @ 23, 02 SAY "Pressione algo ..."
        INKEY(0)
    ENDDO
    CLS
RETURN Nil

FUNCTION CifraDados(cTexto)
    LOCAL lFlag := .T., cResultado := "", cCifraLetra := ""
    FOR cLetra := 1 TO LEN(cTexto)
        cCifraLetra := CHR(ASC(SUBSTR(cTexto, cLetra, 1))+ IIF(lFlag, +31, -31))
        cResultado += cCifraLetra
        lFlag := !lFlag
    NEXT
RETURN cResultado

FUNCTION DecifraDados(cTexto)
    LOCAL lFlag := .T., cResultado := "", cLetraLimpa := ""
    FOR cLetra := 1 TO LEN(cTexto)
        cLetraLimpa := CHR(ASC(SUBSTR(cTexto, cLetra, 1))+ IIF(lFlag, -31, +31))
        cResultado += cLetraLimpa
        lFlag := !lFlag
    NEXT
RETURN cResultado

FUNCTION VerificaCriterioTexto(cTexto)
    LOCAL lUpper, lLower, lDigit, lEspecial, cGrpChr, aResultado, cMensagem
    lUpper := lLower := lDigit := lEspecial := .F.
    cGrpChr    := "@#_-+=/*"
    aResultado := {}
    FOR n := 1 TO LEN(cTexto)
        cSinal := SUBSTR(cTexto, n, 1)
        IF IsUpper(cSinal)
            lUpper := .T.
        ELSEIF IsLower(cSinal)
            lLower := .T.
        ELSEIF IsDigit(cSinal)
            lDigit := .T.
        ELSEIF (cSinal $ cGrpChr)
            lEspecial := .T.
        ENDIF
    NEXT
    cMensagem := "Essa string nao contem pelo menos um:;"
    IF !lUpper
        cMensagem += "- Maiusculo.;"
    ENDIF
    IF !lLower
        cMensagem += "- Minusculo.;"
    ENDIF
    IF !lDigit
        cMensagem += "- Digito.;"
    ENDIF
    IF !lEspecial
        cMensagem += "- Caractere Especial.;"
    ENDIF
    IF (!lUpper .or. !lLower .or. !lDigit .or. !lEspecial)
        alert("Aviso:;" + cMensagem)
        RETURN .F.
    ENDIF
RETURN .T.