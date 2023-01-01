PROCEDURE MAIN

   FT_FUSE( "file.txt" )   // open text file

   WHILE .NOT. FT_FEOF()

      ? FT_FREADLN()

      FT_FSKIP()

   ENDDO

   FT_FUSE()                // close file

RETURN