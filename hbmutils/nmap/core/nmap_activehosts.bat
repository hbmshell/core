@echo off
if "%1" == "" (
	hbmdialog nmap_activehosts.prg --virtual-include
) else (
	hbmdialog nmap_activehosts.prg --virtual-include -ip %1
)
 