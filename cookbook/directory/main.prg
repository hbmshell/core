/*

Mesmo que voc� chame esse execut�vel de outro diret�rio,
o valor retornado ser� o PATH completo de onde est� o execut�vel


Even if you call this executable from another directory,
the returned value will be the full PATH where the executable is located

*/
PROCEDURE MAIN

     ? "Drive and directory name of running executable ( application )", HB_DirBase() 
     

RETURN
