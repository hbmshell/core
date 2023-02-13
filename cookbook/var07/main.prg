

PROCEDURE MAIN

   
    PUBLIC VAR_PUBLIC 
    PRIVATE VAR_PRIVATE
    
    
    // __MVPUT() This function set the value of memory variable
    __MVPUT("VAR_PRIVATE",12)
    ? __MVGET("VAR_PRIVATE") // 12
   
    __MVPUT("VAR_PUBLIC",13)
    ? __MVGET("VAR_PUBLIC") // 13

