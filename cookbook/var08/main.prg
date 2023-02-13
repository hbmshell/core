
STATIC VAR_STATIC_EXT

PROCEDURE MAIN

    LOCAL VAR_LOCAL := "LOCAL"
    STATIC VAR_STATIC_INT := "STATIC INT"
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
   
    // CUIDADO !!!!!
    // WARNING !!!!!    
    // Uma nova variavel foi criada (ela é private)
    // A new variable has been created (it's private)
    __MVPUT("VAR_LOCAL",14) // EQUIVALENT TO M->VAR_LOCAL := 14
    ? __MVGET("VAR_LOCAL") // 14 
    ? __MVSCOPE("VAR_LOCAL") // 2 (PRIVATE)
    ? VAR_LOCAL // A VARIÁVEL LOCAL / LOCAL VARIABLE 
    ?? M->VAR_LOCAL , "<== SAME NAME, BUT DIFFERENT VALUE"// PRIVATE (SAME NAME)

    // WARNING !!!!!    
    // Uma nova variavel foi criada (ela é private)
    // A new variable has been created (it's private)
    __MVPUT("VAR_STATIC_INT",15) 
    ? __MVGET("VAR_STATIC_INT") // 15
    ? __MVSCOPE("VAR_STATIC_INT") // 2 (PRIVATE)
    ? VAR_STATIC_INT // A VARIÁVEL STATIC / STATIC VARIABLE
    
    // __MVRELEASE() This function releases PRIVATE/PUBLIC variables VALUES
    __MVRELEASE("VAR_STATIC_INT")
    __MVRELEASE("VAR_LOCAL")
    ? __MVSCOPE("VAR_STATIC_INT") // 2 (PRIVATE)
    ? __MVSCOPE("VAR_LOCAL") // 2 (PRIVATE)
    __MVCLEAR()
    ? __MVSCOPE("VAR_STATIC_INT") // -1 (STATIC)
    ? __MVSCOPE("VAR_LOCAL") // -1 (LOCAL)
    ? VAR_LOCAL, VAR_STATIC_INT
    
   