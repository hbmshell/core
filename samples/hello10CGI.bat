@echo off
echo http://localhost:12000
echo http://localhost:12000/cgi/index.prg
hbmshell --site fullsite02 --cgi-bin prg --cgi-bin-alias "/cgi" --port 12000 --log-level 4


