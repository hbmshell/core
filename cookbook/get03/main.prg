PROCEDURE HBM_14range

    LOCAL nAge := 0
    LOCAL nSalary := 0

    CLS

    @ 10,10 SAY "Client age  : " GET nAge RANGE 18,99 
    @ 12,10 SAY "Salary : " GET nSalary RANGE 1000,1000000

    SET SCOREBOARD ON // <-- Show message in line 0 
    READ  
    SET SCOREBOARD OFF // Disable if needed

    
    
RETURN
