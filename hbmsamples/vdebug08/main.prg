//#define __DEBUG__
#include "vbase.ch"
PROCEDURE MAIN

    LOCAL oCfg := ConfigSingleton()
    LOCAL x := 1000
    LOCAL c := 'Client Name'
    LOCAL z := { => }
    LOCAL y := { "1" , 2 , 4 , { 12 } }

/**
O comando DEBUG DISPLAY vai criar uma cópia PRIVATE da variável para exibição no depurador
O comando DEBUG DISPLAY <VAR> STOP vai criar a cópia e chamar um break point 

Esse comando é útil para podermos analisar variáveis inacessíveis pelo debugador, como hashs e objetos.
Ao criarmos as variáveis podemos usar o comando WP para chamar as mesmas. 

O nome das variáveis criadas é : __DEBUG_DISPLAY_<nome original>

Para visualizar no debug clique no menu "Monitor" e selecione a opção "Private"
*/

    DEBUG DISPLAY x
    DEBUG DISPLAY y
    DEBUG DISPLAY c
    DEBUG DISPLAY z 
    DEBUG DISPLAY oCfg
    DEBUG DISPLAY oCfg:GetLogName() STOP

    ? "Voce está no depurador. Clique em Monitor -> Private"

    RETURN


