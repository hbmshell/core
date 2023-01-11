
PROCEDURE HBM_20picture

    LOCAL cName := SPACE(30)
    LOCAL nDebt := -1200
    LOCAL nCode := 1300
    LOCAL nSal := 15000
    LOCAL nTax := 1233.56
    LOCAL nRow := 34, nCol := 10, nWidth := 110
    LOCAL dDay := DATE()

    CLS
    
    @ 08,10 SAY "Name                      : " GET cName PICTURE "@A" MESSAGE "@A : Only alphanumeric caracteres (accented letters or Ç,Ñ,etc. will not displayed correctly)"
    @ 10,10 SAY "Debt                      : " GET nDebt PICTURE "@X" MESSAGE "@X : Show DB after negative number"
    @ 12,10 SAY "Code                      : " GET nCode PICTURE "@B" MESSAGE "@B : Align numbers to left"
    @ 14,10 SAY "Salary                    : " GET nSal  PICTURE "@C" MESSAGE "@C : Show CR after positive number"
    @ 16,10 SAY "Tax                       : " GET nTax  PICTURE "@E" MESSAGE "@E : Reverses the position of the colon in numeric variables"

    SET DATE TO AMERICAN
    @ 18,10 SAY "Today                     : " GET dDay  PICTURE "@E" MESSAGE "@E : Display format day/month/year independent of SET DATE format"

    READ MSG AT nRow, nCol, nWidth MSG COLOR "N/W" // <------------------------------------------ MESSAGE Coordinate and width 
    SET DATE TO BRITISH

    WAIT
    
RETURN