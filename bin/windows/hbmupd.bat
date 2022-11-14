@ECHO OFF
set MACHINE=%1
set URL="https://raw.githubusercontent.com/hbmshell/rover/main/%MACHINE%/code.prg"

tasklist /fi "ImageName eq hbmshell.exe" /fo csv 2>NUL | find /I "hbmshell.exe">NUL
if %ERRORLEVEL% neq 0 ( 
    REM Não Existe processo, inicializando
    cd \sistemas
    hbmshell --rover %MACHINE% 
)



