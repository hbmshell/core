// https://vivaclipper.wordpress.com/2014/02/14/with-object/
/**
Description
-----------


To build
--------

hbmk2 main.prg 

*/
// The example builds a simple database browser using a TBrowse object.
// The columns added to the object and the cursor navigation logic is
// programmed using the WITH OBJECT control structure.
#include "inkey.ch"
PROCEDURE Main
  LOCAL oTBrowse, aFields, cField, nKey
  LOCAL aStruct := { { "NOME", "C", 20, 0 },;
    { "TELEFONE", "C", 10, 0 } }

  dbCreate( "agenda", aStruct , "SQLMIX", .T.)
  APPEND BLANK
  REPLACE FIELD->NOME WITH "GERALDO"
  REPLACE FIELD->TELEFONE WITH "980768-9087"
  APPEND BLANK
  REPLACE FIELD->NOME WITH "PATRICK"
  REPLACE FIELD->TELEFONE WITH "980768-9087"
  APPEND BLANK
  REPLACE FIELD->NOME WITH "PABLO"
  REPLACE FIELD->TELEFONE WITH "980768-9087"
  APPEND BLANK
  REPLACE FIELD->NOME WITH "JONH"
  REPLACE FIELD->TELEFONE WITH "980768-9087"  
  GO TOP
  /********************************/
  aFields := Array( FCount() )
  AEval( aFields, {|x,i| aFields[i] := FieldName(i) } )
  oTBrowse := TBrowseDB()
  WITH OBJECT oTBrowse
      FOR EACH cField IN aFields
        :addColumn( TBColumnNew( cField, FieldBlock( cField ) ) )
      NEXT
  END
  nKey := 0
  DO WHILE nKey <> K_ESC
      WITH OBJECT oTBrowse
        DO WHILE .NOT. :stabilize()
        ENDDO
        nKey := Inkey(0)
        SWITCH nKey
            CASE K_UP
              :up()       ; EXIT
            CASE K_DOWN
              :down()     ; EXIT
            CASE K_LEFT
              :left()     ; EXIT
            CASE K_RIGHT
              :right()    ; EXIT
            CASE K_PGUP
              :pageUp()   ; EXIT
            CASE K_PGDN
              :pageDown() ; EXIT
            CASE K_HOME
              :home()     ; EXIT
            CASE K_END
              :end()      ; EXIT
        END
      END
  ENDDO
  CLOSE Customer
RETURN
