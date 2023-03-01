// Shebang line
/**
To build
--------

hbmk2 main.prg hbct.hbc

Notes
-----

This function sets a time span for a DO WHILE loop to run. The function must initialize prior to the loop, 
since you must specify the nDelay parameter in 1/100th seconds. 

Subsequently, the function can be implemented without a parameter for additional loop conditions. 
It returns .T., as long as the designated time span has not yet run out.

The function notes the status of the internal timer at initialization. 
From that point on, the initialization should always precede the respective DO WHILE; otherwise, the time delay is incorrect. 
The passing of midnight (the time resets to the 0 value) is taken into account.

Notas
-----
Esta função define um intervalo de tempo para a execução de um loop DO WHILE. 
A função deve inicializar antes do loop, pois você deve especificar o parâmetro nDelay em 1/100 segundos. 
Posteriormente, a função pode ser implementada sem um parâmetro para condições de loop adicionais. 
Ele retorna .T., contanto que o intervalo de tempo designado ainda não tenha expirado.

Observação:

A função registra o status do temporizador interno na inicialização. 
A partir daí, a inicialização deve sempre preceder o respectivo DO WHILE; caso contrário, o atraso de tempo está incorreto. 
A passagem da meia-noite (a hora volta ao valor 0) é considerada.

*/
PROCEDURE Main

    ? "Waiting 5 seconds"
    WaitPeriod( 500 ) // 5 seconds
    DO WHILE .t. .AND. WaitPeriod()
        ?  " wait 5 seconds"
        Inkey(.3)
    ENDDO
    ? "End"
 
RETURN
