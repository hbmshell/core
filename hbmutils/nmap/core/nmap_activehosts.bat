@echo off
if "%1" == "" (
	hbmdialog nmap_activehosts.prg --virtual-include --pause-after
) else (
	hbmdialog nmap_activehosts.prg --virtual-include -ip %1 --pause-after
)
 