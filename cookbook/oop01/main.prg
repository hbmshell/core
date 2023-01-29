/* #include "hbclass.ch" */

PROCEDURE MAIN

	LOCAL oObj := Test():New( { "chave" => 123 , "nome" => "teste" } )

	? hb_valtoexp( oObj:GetValue() )

	oObj := Test():New()
	? hb_valtoexp( oObj:GetValue() )

	RETURN

CREATE CLASS Test

	DATA nVal

	METHOD NEW( nVal ) CONSTRUCTOR
	METHOD GetValue()

ENDCLASS

METHOD New( nVal ) CLASS TEST

	IF EMPTY( nVal )
	ELSE
		::nVal := nVal
	ENDIF

	RETURN SELF

METHOD GetValue() CLASS TEST

	RETURN ::nVal

