
STATIC VAR_STATIC_EXT

PROCEDURE MAIN

    LOCAL VAR_LOCAL := "LOCAL"
    STATIC VAR_STATIC_INT := "STATIC INT"
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
   
    ? "Var exists"
    ? "VAR_PRIVATE", __MVEXIST("VAR_PRIVATE")  // .t.
    ? "VAR_PUBLIC", __MVEXIST("VAR_PUBLIC")  // .t.
    ? "Var doesn't exists"
    ? "VAR_LOCAL",__MVEXIST("VAR_LOCAL")  // .f.
    ? "VAR_STATIC",__MVEXIST("VAR_STATIC")  // .f.
    ? "VAR_STATIC_EXT",__MVEXIST("VAR_STATIC_EXT")  // .f.
    
    /*
    __MVEXISTS is applicable only in PUBLIC or PRIVATE vars
    */