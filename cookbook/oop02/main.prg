/*
WITH OBJECT
-----------
Harbour supports the following statement:

   WITH OBJECT expression
      ...
   ENDWITH

   Inside this WITH OBJECT/END enclosure you can use the simplified
   form of sending messages to the object. You can use the syntax
   :message( [params] )
   :property
   to send messages to the object specified by `expression`

for example:
   WITH OBJECT myobj:a[ 1 ]:myitem
      :message( 1 )
      :value := 9
   ENDWITH

   The above code is equivalent to:
   myobj:a[ 1 ]:myitem:message( 1 )
   myobj:a[ 1 ]:myitem:value := 9

   Inside WITH OBJECT/END you can access (or even assign a new object)
   using a special reserved property :__withObject()

       The runtime error will be generated at the time of message
       sending (or property access/assign) if <objexpression>
       is not a value of type object.

*/
#include "hbclass.ch" 
PROCEDURE MAIN

	
   WITH OBJECT foo():new()
      ? :name                   // prints `FOO`
      ? :__withObject():name    // also prints `FOO`
      ? :__withObject := bar():new()
      ? :name                   // prints `BAR`
   ENDWITH

RETURN

CREATE CLASS foo
  VAR name INIT "FOO"
ENDCLASS

CREATE CLASS bar
  VAR name INIT "BAR"
ENDCLASS