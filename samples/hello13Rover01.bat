@echo off
echo Verify if script has changed in remote a site
echo If any change detected, run this script
echo Type CTRL+C to cancel
echo
hbmshell --rover ~vla --rover-url http://www.lia.ufc.br --rover-code helloRemoto.prg --pause-after
