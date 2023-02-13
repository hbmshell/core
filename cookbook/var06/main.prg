
PROCEDURE MAIN

    
    //__MVPRIVATE() This function creates a PRIVATE variable
    __MVPRIVATE("VAR_PRIVATE")
    // __MVPUBLIC() This function creates a PUBLIC variable    
    __MVPUBLIC("VAR_PUBLIC")
    
    ? "VAR_PRIVATE : ", __MVSCOPE("VAR_PRIVATE") // 2
    ? "VAR_PUBLIC  : ", __MVSCOPE("VAR_PUBLIC")  // 1
   