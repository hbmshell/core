@echo off
echo Verifica se um determinado script chamado code.prg sofreu modificações
echo Se sim, executa esse script localmente 
echo Tecle CTRL+C para cancelar
echo
hbmshell --rover aux_folder --rover-url https://raw.githubusercontent.com/hbmshell/core/main --pause-after
