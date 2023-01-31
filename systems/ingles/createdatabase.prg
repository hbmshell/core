

**********************************************
* Nome  : Hbm_createdatabase
* Autor : Vlademiro Landim Junior
* Aviso : Copyright(c) - 2021 de
*         Vlademiro Landim 
*         Todos os direitos reservados
* Data  : 2021-08-21
* Versão: Harbour 3.2.0dev (r2104281802)
* Notas : 
/*
*/
***********************************************
#include 'cmdterminal.ch' // integração com o shell
#include 'vdata.ch' //

#define FALHA_NA_CRIACAO_DO_DBF 10
PROCEDURE Hbm_createdatabase( ... )

    LOCAL lResult

    IF EMPTY( hb_PValue( 1 ) )
    ELSE
        IF hb_PValue( 1 ) == "--help"
            hbm_Help()
        ENDIF    
    ENDIF


    ? "Verificando a existência do banco de dados local"
    IF FILE( "word.dbf" )
    ELSE
        IF VLJ_CMDYESNO( "Create file here ?" , { "Y" , "N" } , 2 )
        ELSE
            QUIT
        ENDIF
    ENDIF    

    
    USE word STRUCT StructPalavra() TO lResult
    IF lResult
        ? "Ok"
    ELSE
        ? "Error"
        RETURN ERRORLEVEL FALHA_NA_CRIACAO_DO_DBF
    ENDIF    
    CLOSE 
    USE word
    PACK
    CLOSE 

    RETURN

STATIC FUNCTION StructPalavra()

    LOCAL aStr := {}

    AADD( aStr ,  { "WORD" , "C" , 20 , 0 } )
    AADD( aStr ,  { "MEANING" , "C" , 60 , 0 } )
    AADD( aStr ,  { "ERROR" , "N" , 3 , 0 } )
    AADD( aStr ,  { "RIGHT" , "N" , 3 , 0 } )
    AADD( aStr ,  { "TOTAL" , "N" , 3 , 0 } )

RETURN aStr    


STATIC FUNCTION HBM_HELP

    ? "Objetivo : criar ou atualizar as bases de dados do sistema"
    ? ""
    ? "Códigos de erro"
    ? FALHA_NA_CRIACAO_DO_DBF , " - Problemas na criação do arquivo dbf"
    QUIT

RETURN
