
STATIC VAR_STATIC_EXT

PROCEDURE MAIN

    LOCAL VAR_LOCAL := "LOCAL"
    STATIC VAR_STATIC_INT := "STATIC INT"
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
    
    /*
    __MVSCOPE() If variable exists then returns its scope.    
    */
    ? "Scope"
   
    
    ? "VAR_PRIVATE", __MVSCOPE("VAR_PRIVATE") // 2
    ? "VAR_PUBLIC", __MVSCOPE("VAR_PUBLIC")  // 1
    ? "VAR_UNKNOW", __MVSCOPE("VAR_UNKNOW") // -1
   
    ? "VAR_LOCAL", __MVSCOPE("VAR_LOCAL") // -2
    ? "VAR_STATIC_EXT", __MVSCOPE("VAR_STATIC_EXT") // -2
    ? "VAR_STATIC_INT", __MVSCOPE("VAR_STATIC_INT") // -2
    