
STATIC VAR_STATIC_EXT

PROCEDURE MAIN

    LOCAL VAR_LOCAL := "LOCAL"
    STATIC VAR_STATIC_INT := "STATIC INT"
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
   
    /*
    __MVEXIST () Determina se um determinado nome é uma variável de memória PUBLIC ou PRIVATE
    __MVEXIST() Determine if a given name is a PUBLIC or PRIVATE memory variable
    */
    
    
    ? __MVEXIST("VAR_PRIVATE")  // .T.
    ? __MVEXIST("VAR_PUBLIC")   // .T.
    
    ? __MVEXIST("VAR_UNKNOW")   // .F.
    
    /*
    __MVXRELEASE() This function releases value stored in PRIVATE or PUBLIC
    __MVXRELEASE() Libera o valor armazenado em uma variável PRIVATE ou PUBLIC
    
    */
    VAR_PRIVATE := "OI"
    VAR_PUBLIC := "OLAR"
    ? VAR_PRIVATE , VAR_PUBLIC  // "OI" "OLAR"
    __MVXRELEASE("VAR_PRIVATE")
    ? VAR_PRIVATE , VAR_PUBLIC // nil, "OLAR"

    ? "Var exists"
    ? __MVEXIST("VAR_PRIVATE")  // .t.
    ? __MVEXIST("VAR_PRIVATE")  // .t.
    
    /*
    __MVCLEAR() This function releases all PRIVATE and PUBLIC variables    
                Essa função libera todas as variáveis PUBLIC e PRIVATE
    */
    __MVCLEAR()
    ? "Var doesn't exists"
    ? __MVEXIST("VAR_PRIVATE")  // .f.
    ? __MVEXIST("VAR_PRIVATE")  // .f.
    
    /*
    __MVSCOPE() If variable exists then returns its scope.    
    */
    ? "Scope"
    ? __MVSCOPE("VAR_PRIVATE") // -1
    ? __MVSCOPE("VAR_PUBLIC")  // -1
    
    //__MVPRIVATE() This function creates a PRIVATE variable
    __MVPRIVATE("VAR_PRIVATE")
    // __MVPUBLIC() This function creates a PUBLIC variable    
    __MVPUBLIC("VAR_PUBLIC")
    
    ? __MVSCOPE("VAR_PRIVATE") // 2
    ? __MVSCOPE("VAR_PUBLIC")  // 1
    
    ? __MVSCOPE("VAR_LOCAL") // -2
    ? __MVSCOPE("VAR_STATIC_EXT") // -2
    ? __MVSCOPE("VAR_STATIC_INT") // -2
    
    // __MVPUT() This function set the value of memory variable
    __MVPUT("VAR_PRIVATE",12)
    ? __MVGET("VAR_PRIVATE") // 12
   
    __MVPUT("VAR_PUBLIC",13)
    ? __MVGET("VAR_PUBLIC") // 13



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
    
    // This function releases value stored in PRIVATE or Public
    VAR_PUBLIC := "PUBLIC"
    VAR_PRIVATE := "PRIVATE"
    __MVXRELEASE() 
    ? VAR_PUBLIC, VAR_PRIVATE
    
    FUNCAOQUALQUER()

RETURN

FUNCTION FUNCAOQUALQUER()

    ? "ERRO"
    ? VAR_LOCAL, VAR_STATIC_INT

    RETURN NIL
