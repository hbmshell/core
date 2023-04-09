@echo off
if "%1"==""  GOTO ERRO
hbmdialog browse.prg -dbf %1 --virtual-include  %2 %3 %4 %5 %6 %7 %8 %9
GOTO FIM 
:ERRO
@echo Type PRG script name
:FIM
