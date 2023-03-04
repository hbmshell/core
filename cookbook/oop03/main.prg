// https://programandoxbase.wordpress.com/
#include "hbclass.ch" 

PROCEDURE MAIN
	
   LOCAL oClass := tMinhaClasse():New()
   ? hb_ProgName()
   Qout( "s" + 2, "<<<<< fora" )
   oClass:Add( "a" , 2 )

RETURN
//-------------------------------------------
CREATE CLASS tMinhaClasse 

   PROTECTED:

      DATA   cMensagem INIT ""
   EXPORTED:	

      METHOD New() 	CONSTRUCTOR
      METHOD Add( x , y ) 
      //ERROR HANDLER MetodoDesconhecido()

ENDCLASS

*------------------------------------------ 
METHOD New() CLASS tMinhaClasse
*----------------------------------------- 

      // seu código construtor aqui

Return Self // retorna self


*------------------------------------------ 
METHOD Add( x , y ) CLASS tMinhaClasse
   *----------------------------------------- 
   ? valtype(x)
   ? valtype(y)
   ? x + y
   
   Return NIL

*------------------------------------------
METHOD MetodoDesconhecido() CLASS tMinhaClasse
*-----------------------------------------

      // esse método é chamado quando ocorrer erro
      hb_alert("Error tMinhaCasse " )

Return nil


