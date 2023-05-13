//Thanks Toledo : http://www.pctoledo.com.br/forum/viewtopic.php?f=1&t=10903
/*
Esta rotina utiliza um Browse que destaca os registros com cores
diferentes de acordo com o conteúdo de um campo.

Neste exemplo use a barra de espaço para selecionar o registro
e mudar sua cor.

Para compilar e linkeditar este pequeno exemplo, use:

CLIPPER BRWCOR

RTLINK FI BRWCOR


Autor: TOLEDO - Clipper On Line
       toledo@pctoledo.com.br
       www.pctoledo.com.br


Compartilhe sua experiência
Se você tem uma dica sobre Clipper para compartilhar com toda Comunidade
Clippeira, mande para toledo@pctoledo.com.br, tenho certeza que a sua
dica será muito útil para todos os usuarios do site Clipper On Line.

*/
#include "inkey.ch"
PROCEDURE MAIN
clear
SET DATE BRITISH
SET CENTURY ON
SET SCOREBOARD OFF
PRIV aCampos:={{"cor","!","Sel"},;
{"codi","999999-9","C¢digo"},;
{"usu","@!","Usu rio"}}
SELECT 1
USE USUARIOS
INDEX ON CODI TO IND
SET INDEX TO IND
J_ANELA(2,3,20,76,"B+/BG","N/BG","W/BG"," (ARQUIVO DE USUARIOS) ")
BRW_ARQ(2,3,20,76,aCampos)
retu


PROC BRW_ARQ
PARAMETERS brw_ls,brw_cs,brw_li,brw_ci,brw_campos
brw:=TBrowseNew(brw_ls+1,brw_cs+1,brw_li-1,brw_ci-1)

brw:colorspec := "B/BG,R/BG,G/BG,W+/W,N/BG"
brw:headsep:=chr(205)+chr(209)+chr(205)
brw:colsep:=" "+chr(179)+" "
brw:gotopblock({|| dbGoTop()})
brw:gobottomblock({|| dbGoBottom()})
brw:skipblock({|_1| MOV_PTR(_1)})

FOR i_=1 TO LEN(brw_campos)
 cp_titu:=brw_campos[i_,3]
 cp_masc:=brw_campos[i_,2]
 cp_:=brw_campos[i_,1]
 brw:addcolumn(tbcolumnnew(cp_titu,&("{||TRAN("+cp_+",["+cp_masc+"])}")))
 brw:getcolumn(i_):width := LEN(TRAN(&cp_.,cp_masc))
 brw:getcolumn(i_):colorblock=&("{||IF(cor='X',{1,4},{5,4})}")
NEXT

volta_db=.t.
DO WHILE volta_db
   SETCOLOR("W+/B")
   SET CURSO OFF
   DO WHILE !brw:stabilize() .AND. NEXTKEY()=0
   ENDD
   READINSERT(.f.)
   x_ = COL() ; y_ = ROW()
   tecl_p=INKEY(0)
   carac_ = UPPER(CHR(tecl_p))
   SET CURSO ON
   brw:dehilite()
   DO CASE
         CASE tecl_p = K_ESC
            volta_db=.f.
         CASE tecl_p = K_UP
              brw:up()
         CASE tecl_p = K_DOWN
            brw:down()
         CASE tecl_p = K_RIGHT
            brw:right()
         CASE tecl_p = K_LEFT
            brw:left()
         CASE tecl_p = K_HOME   
            brw:home()
         CASE tecl_p = K_END   
            brw:end()
         CASE tecl_p = K_PGUP   
            brw:pageup()
         CASE tecl_p = K_PGDN   
            brw:pagedown()
         CASE tecl_p = K_CTRL_PGDN
            brw:gobottom()
         CASE tecl_p = K_CTRL_PGUP
            brw:gotop()
         CASE tecl_p = K_CTRL_END   
            brw:panend()
         CASE tecl_p = K_CTRL_HOME   
            brw:panhome()
         CASE tecl_p = K_CTRL_LEFT   
            brw:panleft()
         CASE tecl_p = K_CTRL_RIGHT   
            brw:panright()
         CASE tecl_p = K_SPACE
            IF USUARIOS->cor="X"
              USUARIOS->cor:=" "
            ELSE
              USUARIOS->cor:="X"
            ENDIF
            brw:refreshCurrent()
   ENDC
ENDD
SET CURSO ON
RETU

FUNC MOV_PTR(a_pular)
LOCAL ja_pulado := 0, chv_
IF a_pular = 0
   SKIP 0
ELSE
   DO WHILE !EOF() .AND. !BOF() .AND.;
      a_pular != ja_pulado
      IF a_pular > 0
         SKIP
         ja_pulado++
      ELSE
         SKIP -1
         ja_pulado--
      ENDI
   ENDD
   IF EOF() .OR. BOF()
      IF a_pular > 0
         GO BOTTOM
         ja_pulado--
      ELSE
         GO TOP
         ja_pulado++
      ENDI
   ENDI
ENDI
RETU ja_pulado

FUNCTION J_ANELA
PARAMETERS L1,C1,L2,C2,C_OR1,C_OR2,C_OR3,T_ITULO
CORR=SETCOLOR()
SET COLOR TO &C_OR1
@ L1,C1 CLEAR TO L2,C2
@ L1,C1 SAY 'Ú'+REPLICATE(CHR(196),C2-C1-1)+'¿'
SET COLOR TO &C_OR3
@ L1,(80-LEN(T_ITULO))/2 SAY T_ITULO
FOR A=L1+1 TO L2-1
   SET COLOR TO &C_OR1
   @ A,C1 SAY '³'
   SET COLOR TO &C_OR2
   @ A,C2 SAY '³'
NEXT A
SET COLOR TO &C_OR2
@ L2,C1 SAY 'À'+REPLICATE(CHR(196),C2-C1-1)+'Ù'
SETCOLOR(CORR)
RETURN
