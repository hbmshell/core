FUNCTION Main()


    HB_MemoWrit( "novo.jpg" , Imagem() )


    RETURN NIL

FUNCTION Imagem()

  LOCAL cReturn := ""
 
#pragma __binarystreaminclude "imagem/01.jpg"   | cReturn := %s 
  
RETURN cReturn
