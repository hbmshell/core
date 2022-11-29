@echo off
echo Verify if script has changed in remote a site
echo If any change detected, run this script
echo Type CTRL+C to cancel
echo
hbmshell --rover aux_folder --rover-url https://raw.githubusercontent.com/hbmshell/core/main --pause-after
