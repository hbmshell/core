
STATIC VAR_STATIC_EXT

PROCEDURE MAIN
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
   
    /*
    __MVEXIST () Determina se um determinado nome é uma variável de memória PUBLIC ou PRIVATE
    __MVEXIST() Determine if a given name is a PUBLIC or PRIVATE memory variable
    */
    
    
    ? __MVEXIST("VAR_PRIVATE")  // .T.
    ? __MVEXIST("VAR_PUBLIC")   // .T.
    
    ? __MVEXIST("VAR_UNKNOW")   // .F.
    ? __MVEXIST("VAR_STATIC_EXT") // .F.
  
RETURN


