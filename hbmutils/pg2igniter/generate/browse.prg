#include 'cmdterminal.ch' // integração com o shell
#include "dcufc.ch"
#include "dbstruct.ch"
PROCEDURE Hbm_Browse( ... )
    MODULE SHELL
    LOCAL hParams , cPrintParams
    LOCAL oObj
    LOCAL x, aRow, aCol := {}
    
    SHELL ADD PARAM "--no-memo" TITLE "Não inclua o campo memo" BOOLEAN
    SHELL ADD PARAM "--columns" TITLE "Lista de colunas, separadas por vírgulas, a serem exibidas (p.ex:2,3,4)" STRING DEFAULT "all"
    SHELL ADD PARAM "--dbf" TITLE "Nome do arquivo" STRING MANDATORY
    SHELL PRINT HELP TO cPrintParams
    IF hb_PValue(1) == "--help"
        Hbm_Help( cPrintParams )
    ENDIF
    SHELL GET PARAMS TO hParams

    IF .NOT. FILE( IIF( EMPTY( hb_FNameExt(hParams["--dbf"])),; 
                                        hParams["--dbf"] + ".dbf" , hParams["--dbf"] )  )
        SHELL ERROR "O arquivo " + hParams["--dbf"] + " não foi encontrado" ERRORCODE 100
    ENDIF
    USE ( hParams["--dbf"] ) SHARED
    IF hParams["--columns"] == "all"
        FOR x := 1 TO FCOUNT()
            AADD( aCol , x )
        NEXT
    ELSE
        AEVAL( hb_ATokens( hParams["--columns"] , "," ) , {|xElem| AADD( aCol , VAL(xElem)) })
    ENDIF        
    DO WHILE .NOT. EOF()
        aRow := {}
        FOR x := 1 TO FCOUNT()
            IF IIF( hParams["--no-memo"] , dbStruct()[x][DBS_TYPE] == "M" , .f. )
            ELSE 
                IF ASCAN( aCol , x ) <> 0   
                    AADD( aRow , &(FIELDNAME(x)) )
                ENDIF    
            ENDIF
        NEXT
        SKIP
    ENDDO
RETURN 
//---------------------------------------------------------
STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "" )
    ? "Objetivo : Exibe o conteúdo de um arquivo (.dbf)"
    ?
    ? "Parâmetros"
    ? "--help    Help"
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF

    QUIT

RETURN

