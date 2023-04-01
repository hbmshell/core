//#define __DEBUG__
#include "vbase.ch"
PROCEDURE MAIN

/**
O comando DEBUG BP vai criar um ponto de parada (Break point) no local onde ele for executado.
O comando DEBUG BP <condição> vai criar um ponto de parada condicional, que só será executado se 
    <condição> for verdadeira.
*/
    ? "Teste de parada"
    DEBUG BP
    ? "Linha após o teste. Agora testando o BP condicional. Tecle algo."
    INKEY(0)
    DEBUG BP 1+1==2
    ? "Linha após o teste. Agora testando o BP condicional falso. Tecle algo."
    INKEY(0)
    DEBUG BP 1+1==3

    RETURN


