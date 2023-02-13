
STATIC VAR_STATIC_EXT

PROCEDURE MAIN

    LOCAL VAR_LOCAL := "LOCAL"
    STATIC VAR_STATIC_INT := "STATIC INT"
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
   
    /*
    __MVCLEAR() This function releases all PRIVATE and PUBLIC variables    
                Essa função libera todas as variáveis PUBLIC e PRIVATE
    */
    __MVCLEAR()
    ? "Var doesn't exists"
    ? __MVEXIST("VAR_PRIVATE")  // .f.
    ? __MVEXIST("VAR_PRIVATE")  // .f.
    
   