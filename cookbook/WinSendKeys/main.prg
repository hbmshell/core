//https://learn.microsoft.com/pt-br/office/vba/language/reference/user-interface-help/sendkeys-statement
//http://www.pctoledo.com.br/forum/viewtopic.php?f=4&t=19089&p=122681&hilit=sendkeys#p122681
PROCEDURE Main

    LOCAL oShell:= TOleAuto():New( "WScript.Shell" )
    oShell:run( "calc.exe" ) 
    Inkey(1)
    oShell:AppActivate("Calculadora") // Caption title app here (changeit accord with you need)
    oShell:SendKeys("%")
    oShell:SendKeys("12")
    oShell:SendKeys("{+}")
    oShell:SendKeys("21")
    oShell:SendKeys("~")
    //oShell:SendKeys("%{F4}")
    
RETURN