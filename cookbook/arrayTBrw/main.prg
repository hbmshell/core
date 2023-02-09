

* Rotina inicial desenvolvida pelo site: Clipper On Line - Toledo
* Endereco: www.pctoledo.com.br
* Para testar esta rotina, execute em uma pasta onde tem vários
* arquivos.
* 
* Pequenas alterações feitas por Vlademiro (Ago 2019)
*
******************************************************************/
#include "inkey.ch"
PROCEDURE Main

    CLEAR
    PRIVATE aMatriz1
    SET DATE BRITISH
    SET CENTURY ON
    SET SCOREBOARD OFF
    aMatriz1 := Directory( "*.*" )  // cria uma matriz com os dados dos arquivos
    ASort( aMatriz1,,, {| x, y | x[ 1 ] < y[ 1 ] } )
    BRW_MATRIZ( aMatriz1 )

    RETURN


PROCEDURE BRW_MATRIZ( aBrw )

    LOCAL oBrw := TBrowseNew( 3, 13, 19, 67 )
    LOCAL lVoltaDb AS LOGICAL

    LOCAL n := 1, ntot := Len( aBrw )

    oBrw:colorspec := "W+/B,B/W,W+/R,W+/BG,GR+/GR"
    oBrw:headsep := Chr( 205 ) + Chr( 209 ) + Chr( 205 )
    oBrw:colsep := " " + Chr( 179 ) + " "
    oBrw:gotopblock( {|| n := 1 } )
    oBrw:gobottomblock( {|| n := ntot } )
    oBrw:skipblock( {| _1 | ( n := n + _1, iif( n < 1, _1 := _1 - n + ( n := ;
       1 ), iif( n > ntot, _1 := _1 - ( n - ( n := ;
       ntot ) ), NIL ) ), _1 ) } )


    oBrw:addcolumn( TBColumnNew( "Arquivo", {|| TRANS( aBrw[ n, 1 ], "@!" ) } ) )
    oBrw:getcolumn( 1 ):width := 12
    oBrw:getcolumn( 1 ):cargo := { "@!" }
    oBrw:addcolumn( TBColumnNew( "Tamanho", {|| TRANS( aBrw[ n, 2 ], "@E 99,999,999" ) } ) )
    oBrw:getcolumn( 2 ):width := 10
    oBrw:getcolumn( 2 ):cargo := { "@E 99,999,999" }
    oBrw:addcolumn( TBColumnNew( "Data", {|| TRANS( aBrw[ n, 3 ], "@D" ) } ) )
    oBrw:getcolumn( 3 ):width := 10
    oBrw:getcolumn( 3 ):cargo := { "@!" }
    oBrw:addcolumn( TBColumnNew( "Hora", {|| TRANS( aBrw[ n, 4 ], "@!" ) } ) )
    oBrw:getcolumn( 4 ):width := 8
    oBrw:getcolumn( 4 ):cargo := { "@!" }
    lVoltaDb = .T.
    DO WHILE lVoltaDb
        SetColor( "W+/B" )
        DO WHILE !oBrw:stabilize() .AND. NextKey() = 0
        ENDDO
        tecl_p=INKEY(0)

        oBrw:dehilite()
        DO CASE
        CASE tecl_p = K_ESC
            lVoltaDb = .F.
        CASE tecl_p = K_UP
            oBrw:up()
        CASE tecl_p = K_DOWN
            oBrw:down()
        CASE tecl_p = K_RIGHT
            oBrw:Right()
        CASE tecl_p = K_LEFT
            oBrw:Left()
        CASE tecl_p = K_HOME
            oBrw:home()
        CASE tecl_p = K_END
            oBrw:end()
        CASE tecl_p = K_PGUP
            oBrw:pageup()
        CASE tecl_p = K_PGDN
            oBrw:pagedown()
        CASE tecl_p = K_CTRL_PGDN
            oBrw:gobottom()
        CASE tecl_p = K_CTRL_PGUP
            oBrw:gotop()
        CASE tecl_p = K_CTRL_END
            oBrw:panend()
        CASE tecl_p = K_CTRL_HOME
            oBrw:panhome()
        CASE tecl_p = K_CTRL_LEFT
            oBrw:panleft()
        CASE tecl_p = K_CTRL_RIGHT
            oBrw:panright()


        ENDCASE
    ENDDO
    SET CURSOR ON

    RETURN
