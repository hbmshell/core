
#include "grumpbro.ch"

PROCEDURE MAIN

     dbCreate( "user.dbf" , { { "LOGIN" , "C" , 30 , 0 } , { "PASS" , "C" , 30 , 0 } } )
 
     USE user    
     GRUMPBROW



RETURN
