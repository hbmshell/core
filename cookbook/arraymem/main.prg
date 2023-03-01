/*
   Salva Matriz em disco usando as funções:
   Hb_Serialize() e Hb_DeSerialize()

   Nota: Veja que propositalmente todas variáveis foram declaradas com tamanho
   maior que 10 caracteres, já que as funções Hb_MvSave() e Hb_MvRestore()
   salva variáveis com nomes longos, nao limitado a apenas 10 caracteres
*/


Function Main()
   /*
     Aqui podem ser declaradas como Local, mas vamos declarar como
     Private para sofrer o efeito do comando Release, que não afeta
     variáveis declaradas Local
   */
   Private aPrimeiraMatriz := {}
   Private aSegundaMatriz := {}
   Private aMatrizMaster := {}

   /*
     Esta precisa ser Private ou Public, pois não é possível
     salvar variáveis Local, Static, Array ou Block
   */
   Private cMatrizSerializada

   /*
     Vamos montar uma primeira matriz bidimensional:
   */
   AaDd( aPrimeiraMatriz, { Date() + 1, "Campinas", 123.45 } )
   AaDd( aPrimeiraMatriz, { Date() + 2, "Paulinia", 123.46 } )
   AaDd( aPrimeiraMatriz, { Date() + 3, "Sao Paulo", 123.47 } )
   AaDd( aPrimeiraMatriz, { Date() + 4, "Rio de Janeiro", 123.48 } )

   /*
     Vamos montar uma segunda matriz bidimensional:
   */
   AaDd( aSegundaMatriz, { Date() + 5, "Andre", "Paulinia", 1994 } )
   AaDd( aSegundaMatriz, { Date() + 6, "Carolina", "Paulinia", 1996 } )
   AaDd( aSegundaMatriz, { Date() + 7, "Pedro", "Paulinia", 1998 } )
   AaDd( aSegundaMatriz, { Date() + 8, "Beatriz", "Paulinia", 2002 } )

   /*
     Para facilitar, vamos inserir as matrizes que queremos salvar
     em uma matriz Master:
   */
   AaDd( aMatrizMaster, { aPrimeiraMatriz, aSegundaMatriz } )

   /*
     Para poder salvar, vamos Serializar e colocar o resultado
     numa variável. O conteúdo retornado é tipo CARACTER:
   */
   cMatrizSerializada := Hb_Serialize( aMatrizMaster )

   /*
     Salva em arquivo. Se não for definida a extensão, será .hbv
   */
   Hb_MvSave( "MeuArray.Mem", "cMatrizSerializ*" )

   /*
     Vamos apagar todas as variáveis:
   */
   Release All

   /*
     Vamos provar que foram apagadas:
   */
   If Type( "aMatrizMaster" ) = "U"
    MsgInfo( [Variavel "aMatrizMaster" nao existe!], "Nenhuma variável em memória" )
   Endi

   /*
     Vamos restauar as variaveis salvas no disco:
   */
   Hb_MvRestore( "MeuArray.Mem", .T. )

   /*
     Vamos deserializar a variável caracter para que ela volte
     a ser uma Matriz (Array):
   */
   aMatrizMaster := Hb_DeSerialize( cMatrizSerializada )

   /*
     Vamos apagar a variável "cMatrizSerializada", desnecessaria agora:
   */
   Release cMatrizSerializada

   /*
     Vamos recompor nossas matrizes:
   */
   aPrimeiraMatriz := aMatrizMaster[ 1, 1 ]
   aSegundaMatriz := aMatrizMaster[ 1, 2 ]

   /*
     E vamos mostrar que foram restauradas:
   */
   MsgInfo( Padc( hb_ValToExp( aPrimeiraMatriz[ 1, 2 ] ), 50 ), "aPrimeiraMatriz [1,2]" )
   MsgInfo( Padc( hb_ValToExp( aSegundaMatriz[ 2, 3 ] ), 50 ), "aSegundaMatriz [2,3]" )

   MsgInfo( Padc( hb_ValToExp( aMatrizMaster[ 1, 1, 2 ] ), 50 ), "aMatrizMaster [1, 1, 2]" )
   MsgInfo( Padc( hb_ValToExp( aMatrizMaster[ 1, 1, 2, 3 ] ),50 ), "aMatrizMaster [1, 1, 2, 3]" )

Return

Static Procedure MsgInfo( a , b )

   ? b , " --->" , b

return