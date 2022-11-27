@echo off
@del *.log 2>nul
hbmshell vlj_DownloadTests.prg

if exist test_error.log (
	echo *****************************************************************
	echo * Errors detected
	echo *****************************************************************
	type test_error.log
)