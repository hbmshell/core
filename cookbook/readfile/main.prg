/* Test program for new class that reads a file one line at a time
   Donated to the public domain on 2001-03-08 by David G. Holm <dholm@jsd-llc.com>
 */
//https://github.com/harbour/core/blob/master/contrib/hbmisc/tests/readfile.prg
//#require "hbmisc"

PROCEDURE Main(  )

   LOCAL oFile := TFileRead():New( "main.prg" )

   oFile:Open()
   IF oFile:Error()
      ? oFile:ErrorMsg( "FileRead:" )
   ELSE
      DO WHILE oFile:MoreToRead()
         ? oFile:ReadLine()
      ENDDO
      oFile:Close()
   ENDIF

   RETURN