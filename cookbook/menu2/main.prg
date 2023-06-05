//Thanks : http://www.pctoledo.com.br/forum/viewtopic.php?f=43&t=15281
/*
===================================================================================================
Testando função de menu completo
===================================================================================================
Data: 23/07/2014
Yugi386
===================================================================================================
hbmk2 main_menu -lhbct
*/

#include "constantes.prg"
#include "incluir.prg"

PROCEDURE Main()
    hb_cdpselect("UTF8")
    ylib_iniciar(YLIB_TOTAL_LINHAS,YLIB_TOTAL_COLUNAS,YLIB_LINHA_STATUS,1)
    ylib_cls()

do while.t.
    ylib_JanelaMain("Harbour","w+/G","w/b","n/w,w+/r","N/W",maxrow(),5,1)

    menuTotal := { ;
                 {" Menu 1 "," Menu 1 ",.t.,{0,0}},;
                 {"        "," Menu 1.1 - testando sistema"," Menu 1.1 ",.t.,{0,0}},;
                 {"        "," "," Menu 1.1.1 "," Menu 1.1.1 ",.t.,{0,0}},;
                 {"        "," "," Menu 1.1.2 - testando "," Menu 1.1.2 ",.t.,{0,0}},;
                 {"        "," ","         "," Menu 1.1.2.1 - testando "," Menu 1.1.2.1 ",.t.,{0,0}},;
                 {"        "," ","","         "," Menu 1.1.2.1.1 - testando "," Menu 1.1.2.1.1 ",.t.,{0,0}},;
                 {"        "," ","","         "," Menu 1.1.2.1.2 - testando "," Menu 1.1.2.1.2 ",.t.,{0,0}},;
                 {"        "," ","","         "," Menu 1.1.2.1.3 - testando "," Menu 1.1.2.1.3 ",.t.,{0,0}},;
                 {"        "," ","         "," Menu 1.1.2.2 - testando "," Menu 1.1.2.2 ",.t.,{0,0}},;
                 {"        "," ","         "," Menu 1.1.2.3 - testando "," Menu 1.1.2.3 ",.t.,{0,0}},;
                 {"        "," "," Menu 1.1.3 "," Menu 1.1.1 ",.t.,{0,0}},;
                 {"        "," Menu 1.2 "," Menu 1.2 ",.t.,{0,0}},;
                 {"        "," Menu 1.3 "," Menu 1.3 ",.t.,{0,0}},;
                 {"        "," Menu 1.4 "," Menu 1.4 ",.t.,{0,0}},;
                 {"        "," Menu 1.5 "," Menu 1.5 ",.t.,{0,0}},;
                 {"        "," Menu 1.6 "," Menu 1.6 ",.t.,{0,0}},;
                 {"        "," Menu 1.7 ÇÇÇÇÇç}ºª "," Menu 1.7",.t.,{0,0}},;
                 {"        "," Menu 1.8 "," Menu 1.8 ",.t.,{0,0}},;
                 {"        "," Menu 1.9 "," Menu 1.9 ",.t.,{0,0}},;
                 {"        ","-","",.t.,{0,0}},;
                 {"        "," Menu 1.10 "," Menu 1.10 ",.t.,{0,0}},;
                 {" Menu 2 "," Menu 2 ",.f.,{0,0}},;
                 {"        "," Menu 2.1 "," Menu 2.1 ",.t.,{0,0}},;
                 {"        "," Menu 2.2 "," Menu 2.2 ",.t.,{0,0}},;
                 {"        ",""," Menu 2.2.1 "," Menu 2.2.1 ",.t.,{0,0}},;
                 {"        ","",""," Menu 2.2.1.1 "," Menu 2.2.1.1 ",.t.,{0,0}},;
                 {"        ","",""," Menu 2.2.1.2 "," Menu 2.2.1.2 ",.t.,{0,0}},;
                 {"        ","",""," Menu 2.2.1.3 "," Menu 2.2.1.3 ",.t.,{0,0}},;
                 {"        ",""," Menu 2.2.2 "," Menu 2.2.2 ",.t.,{0,0}},;
                 {"        ",""," Menu 2.2.3 "," Menu 2.2.3 ",.t.,{0,0}},;
                 {"        "," Menu 2.3 "," Menu 2.3 ",.t.,{0,0}},;
                 {"        "," "," Menu 2.3.1 "," Menu 2.3.1 ",.t.,{0,0}},;
                 {"        "," "," Menu 2.3.2 "," Menu 2.3.2 ",.t.,{0,0}},;
                 {"        "," "," "," Menu 2.3.2.1 "," Menu 2.3.2.1 ",.t.,{0,0}},;
                 {"        "," "," "," Menu 2.3.2.2 "," Menu 2.3.2.2 ",.t.,{0,0}},;
                 {"        "," "," "," Menu 2.3.2.3 "," Menu 2.3.2.3 ",.t.,{0,0}},;
                 {"        ","-","",.t.,{0,0}},;
                 {"        "," Menu 2.4 "," Menu 2.4 ",.t.,{0,0}},;
                 {" Menu 3 "," Menu 3 ",.t.,{0,0}},;
                 {"        "," Menu 3.1 "," Menu 3.1 ",.t.,{0,0}}, ;
                 {" Menu 4 "," Menu 4 ",.t.,{0,0}},;
                 {"        "," Menu 4.1 "," Menu 4.1 ",.t.,{0,0}},;
                 {"        "," Menu 4.2 "," Menu 4.2 ",.t.,{0,0}},;
                 {"        ","         "," Menu 4.2.1 "," Menu 4.2.1 ",.t.,{0,0}},;
                 {"        ","         "," Menu 4.2.2 "," Menu 4.2.2 ",.t.,{0,0}},;
                 {"        ","         ","-","",.t.,{0,0}},;
                 {"        ","         "," Menu 4.2.3 "," Menu 4.2.3 ",.t.,{0,0}},;
                 {"","",""," Menu 4.2.3.1 "," Menu 4.2.3.1 ",.t.,{1,0}},;
                 {"","",""," Menu 4.2.3.2 "," Menu 4.2.3.2 ",.t.,{0,0}},;
                 {"","","",""," Menu 4.2.3.2.1 "," Menu 4.2.3.2.1 ",.t.,{1,0}},;
                 {"","","",""," Menu 4.2.3.2.2 "," Menu 4.2.3.2.2 ",.t.,{0,0}},;
                 {"","","",""," Menu 4.2.3.2.3 "," Menu 4.2.3.2.3 ",.t.,{0,0}},;
                 {"        ","         "," Menu 4.2.4 "," Menu 4.2.4 ",.t.,{0,0}},;
                 {"        "," Menu 4.3 "," Menu 4.3 ",.f.,{0,0}},;
                 {"        ","-","",.t.,{0,0}},;
                 {"        "," Menu 4.4 "," Menu 4.4 ",.t.,{0,0}}, ;
                 {" Menu 5 "," Menu 5 ",.t.,{0,0}},;
                 {"        "," Menu 5.1 "," Menu 5.1 ",.t.,{0,0}},;
                 {"        "," Menu 5.2 "," Menu 5.2 ",.t.,{0,0}},;
                 {"        "," Menu 5.3 "," Menu 5.3 ",.f.,{0,0}},;
                 {"        ","-","",.t.,{0,0}},;
                 {"        "," Menu 5.4 "," Menu 5.4 ",.t.,{0,0}} ,;
                 {"        "," "," Menu 5.4.1 "," Menu 5.4.1 ",.t.,{0,0}}, ;
                 {"        "," "," "," Menu 5.4.1.1 "," Menu 5.4.1.1 ",.t.,{1,0}}, ;
                 {"        "," "," "," Menu 5.4.1.2 "," Menu 5.4.1.2 ",.t.,{0,0}}, ;
                 {"        ",""," "," "," Menu 5.4.1.2.1 "," Menu 5.4.1.2.1 ",.t.,{1,0}}, ;
                 {"        ",""," "," "," Menu 5.4.1.2.2 "," Menu 5.4.1.2.2 ",.t.,{0,0}}, ;
                 {"        ",""," "," "," Menu 5.4.1.2.3 "," Menu 5.4.1.2.3 ",.t.,{0,0}}, ;
                 {"        ",""," "," ","-","",.t.,{0,0}}, ;
                 {"        ",""," "," "," Menu 5.4.1.2.4 "," Menu 5.4.1.2.4 ",.t.,{0,0}}, ;
                 {"        "," Menu 5.5 "," Menu 5.5 ",.t.,{0,0},"",""} ,;
                 {"        "," Menu 5.6 "," Menu 5.6 ",.t.,{0,0}} ,;
                 {"        "," Menu 5.7 "," Menu 5.7 ",.t.,{0,0}} ,;
                 {"        "," Menu 5.8 "," Menu 5.8 ",.t.,{0,0}} ,;
                 {"        "," Menu 5.9 "," Menu 5.9 ",.t.,{0,0}} ;
                 }

    opc := ylib_mainMenu(1,1,menuTotal,"N/W,w+/R",1,YLIB_LINHA_STATUS,"R/w",2,"N+/N")
   
    ylib_janela("Opção Escolhida",19,45,23,75,"w+/gr","N/w",1,0,,,)

    ylib_center(21,opc,"N/w")

   if opc == "0"
        ylib_center(22,"Saindo do Sistema","N/w")
        inkey(0)
        exit
    endif
    inkey(0)
   
enddo

set color to
cls

return nil