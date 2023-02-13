
STATIC VAR_STATIC_EXT

PROCEDURE MAIN

    LOCAL VAR_LOCAL := "LOCAL"
    STATIC VAR_STATIC_INT := "STATIC INT"
    
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
    
    /*
    __MVXRELEASE() This function releases value stored in PRIVATE or PUBLIC
    __MVXRELEASE() Libera o valor armazenado em uma variável PRIVATE ou PUBLIC
    
    */
    VAR_PRIVATE := "OI"
    VAR_PUBLIC := "OLAR"
    ? "VAR_PRIVATE , VAR_PUBLIC : ", VAR_PRIVATE , " / " ,  VAR_PUBLIC  // "OI" "OLAR"
    __MVXRELEASE("VAR_PRIVATE")
    ? '__MVXRELEASE("VAR_PRIVATE")'
    ? "VAR_PRIVATE , VAR_PUBLIC : ", VAR_PRIVATE , " / " , VAR_PUBLIC // nil, "OLAR"

    ? "Determine if Var exists"
    ? __MVEXIST("VAR_PUBLIC")  // .t.
    ? __MVEXIST("VAR_PRIVATE")  // .t.
    