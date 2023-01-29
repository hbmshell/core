/*

Mesmo que você chame esse executável de outro diretório,
o valor retornado será o PATH completo de onde está o executável


Even if you call this executable from another directory,
the returned value will be the full PATH where the executable is located

*/
PROCEDURE MAIN

     ? "Drive and directory name of running executable ( application )", HB_DirBase() 
     

RETURN
