
PROCEDURE Main

    LOCAL cDate := "20230513", d
    
    ? d := StoD( cDate ), ValType( d )
    ? "test with invalid date ('-' is invalid) : ", cDate := "2023-05-13"
    ? d := StoD( cDate ), ValType( d ), "<----", "Data type is date, but is empty"
    
      

RETURN
 