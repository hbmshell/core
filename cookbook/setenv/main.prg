

PROCEDURE Main

    ? "Inside program"
    ? "Setting value" , hb_SetEnv( "HARBOUR" , "Power" )
    ? "Value for HARBOUR : " , hb_GetEnv( "HARBOUR" )
    ? "Call Subshell and see value for HARBOUR : "
    RUN ( "%comspec% /c echo %HARBOUR%" )
    ? "End Program"
    
     
RETURN



