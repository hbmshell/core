Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c hbmgui main.prg --codepage PTISO"
oShell.Run strArgs, 0, false