/*
 alltrim
*/
PROCEDURE Main
LOCAL cNome , cSobreNome
   
   cNome := "     Robert          "
   cSobreNome := "       Smith      "

   ? "cNome : ", cNome
   ? "cSobreNome : " , cSobreNome 

   ? "cNome + cSobreNome without ALLTRIM : ", cNome + " " + cSobreNome
   cNome := AllTrim( cNome )
   cSobreNome := AllTrim( cSobreNome )
   ? "cNome + cSobreNome with ALLTRIM    : ", cNome + " " + cSobreNome 
   

RETURN