@echo off
@del *.log 2>nul

hbmshell vlj_DownloadTests.prg 1>2>nul
hbmshell vlj_ArrayToString.prg 1>2>nul

if exist test_error.log (
	echo *****************************************************************
	echo * Errors detected
	echo *****************************************************************
	type test_error.log
) else (
	echo Success!
)