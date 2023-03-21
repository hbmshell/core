PROCEDURE HBM_15valid

    LOCAL nAge := 0
    LOCAL cName := SPACE(30)

    CLS
    
    @ 08,10 SAY "Name        : " GET cName VALID IIF(EMPTY( cName ) , (alert("Name is mandatory"),.f.) , .t. )
    @ 10,10 SAY "Client age  : " GET nAge VALID IIF(nAge >= 18 .AND. nAge <= 99 , .t. , (Alert("Age must between 18 and 99"),.f.) )

    READ  

RETURN
