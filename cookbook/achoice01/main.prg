// Shebang line - Optional
// Compile option (e.g: //-p) - Optional
/**
To build
--------

hbmk2 main.prg 

*/
PROCEDURE main

    LOCAL nOpt
    LOCAL aOpcoes := { "Print document" ,;
                       "Send e-mail",;
                       "Send SMS" }

    CLS
    nOpt := Achoice( 10 , 10 , 12 , 30 , aOpcoes )

    @ 15,0 SAY "achoice() return : " + STR(nOpt)


RETURN