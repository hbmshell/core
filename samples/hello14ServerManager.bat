@echo off
echo Ativa o servidor de arquivos na porta especificada
echo A porta padrão é 8080
echo Tecle CTRL+C para cancelar
echo http://localhost:8080
echo 
hbmshell --server-manager --server-manager-root "C:\Temp"
