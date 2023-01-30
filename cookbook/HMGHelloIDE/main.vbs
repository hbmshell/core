Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c hbmhmg main.prg"
oShell.Run strArgs, 0, false