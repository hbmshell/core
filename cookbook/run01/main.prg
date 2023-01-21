
/*
The function, as the name implies, opens a new process on the OS. 

The "dir" command will never be a new process, 
it's just a command interpreted by command.com. 

There is no executable "dir.exe".

http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=12597
*/
PROCEDURE Main

    LOCAL nResultado, cComando, cSalida:="", cError:=""
    
    //cComando := "notepad"
    cComando := "tasklist"
     ? "Executing : ", cComando
    nResultado:=hb_processrun(cComando ,,@cSalida,@cError,.f.)    // .T. wait return function
    
    
    ? "Result : ", hb_ValToexp( nResultado )
    ? "Exit : " , cSalida
    ? "Error : " , cError
     
RETURN


