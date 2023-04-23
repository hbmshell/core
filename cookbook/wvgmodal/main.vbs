Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c hbmwvg main.prg --virtual-include"
oShell.Run strArgs, 0, false