

PROCEDURE MAIN

     LOCAL cPassword := "secret"
     LOCAL nRow := ROW()
     LOCAL nTries := 3

     ? "Password is 'secret'"

     Pass_Chk(cPassword, nRow, nTries)

RETURN
