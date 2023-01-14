#!/usr/local/bin/hbmshell
procedure main


LOCAL cHostName := "localhost"
LOCAL cUserName := "root"
LOCAL cPassWord := ""
LOCAL oServer := TMySQLServer():New( cHostName, cUserName, cPassWord )
	
	IF( oServer:NETERR() )
	
		? "Error!" +CHR(13)+CHR(10)+ "(" + oServer:ERROR() + ")" + CHR(13) + CHR(10) +;
					"Server: " + cHostName + CHR(13)+CHR(10) +;
					"User: " + cUserName , "SQL" 
	
    ELSE 

        ? "Success"
		
	ENDIF