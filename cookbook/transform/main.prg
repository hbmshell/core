//http://www.ouka.com.br/carol/e-book/pre-programacao/clipper.html
//https://vivaclipper.wordpress.com/2012/09/12/what-is-picture-function-template/
/*
---------------------------------------------------------------------
Function Action
---------------------------------------------------------------------
B Displays numbers left-justified
C Displays CR after positive numbers
D Displays dates in SET DATE format
E Displays dates and numbers in British format
R Nontemplate characters are inserted
X Displays DB after negative numbers
Z Displays zeros as blanks
( Encloses negative numbers in parentheses
! Converts alphabetic characters to uppercase
---------------------------------------------------------------------

---------------------------------------------------------------------
Template Action
---------------------------------------------------------------------
A,N,X,9,# Displays digits for any data type
L Displays logicals as "T" or "F"
Y Displays logicals as "Y" or "N"
! Converts alphabetic characters to uppercase
$ Displays a dollar sign in place of a leading space in a number
* Displays an asterisk in place of a leading space in a number
. Specifies a decimal point position
, Specifies a comma position
---------------------------------------------------------------------
*/
PROCEDURE Main

    ? "@! to uppercase", TRANSFORM("editora erica", "@!") // resultado: EDITORA ERICA

    RETURN