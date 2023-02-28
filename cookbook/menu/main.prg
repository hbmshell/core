#include "button.ch"
#include "inkey.ch"
PROCEDURE  hb_Main(...)

    LOCAL oMainMenu  
    LOCAL bMenuBlock := {||NIL}  //{| o | MenuSelect( o ) }
    LOCAL cMenuColor := "N/BG,W+/R,GR+/BG,GR+/R,N+/BG,N/BG"
    LOCAL hElement, hMenu
    LOCAL aItem, oItem, oSubMenu
    LOCAL nOpc

	CLS // Limpa a tela 
    //SetMode( 25, 80 ) // Tamanho da sua janela. Altere se desejar. Por exemplo: SetMode( 50, 150 )
    
    // MENU_SEPARATOR, HB_MENU_SEPARATOR_UNI
   
    /*
    Ítens
    */
    hMenu := { => } 
    hMenu[ "Main" ] := { ;
       { " &Teste For...Next ", K_ALT_T, "Teste For Next", 11 }, ;
       { " &Save ", K_ALT_S, "Save routine", 12 }, ;
       { MENU_SEPARATOR  ,         ,                 , 13 }, ; 
       { " E&xit ", K_ALT_X, "Exit program", 14 }  ;
       } 

    hMenu[ "Report" ] := { ;
       { " &Main Report ", K_ALT_M, "Report main", 21 }, ;
       { " Account details ", , "Details for account main", 24 }  ;
       } 


	// Aqui o menu é montado  
    oMainMenu  := HBTopBarMenu():new( 0, 0, MaxCol() )
    oMainMenu:colorSpec := cMenuColor


    FOR EACH hElement IN hMenu
        oSubMenu  := Popup():new()
        oSubMenu:colorSpec := oMainMenu:colorSpec
        FOR EACH aItem IN hElement
            oItem := MenuItem():new( aItem[ 1 ], ;
               bMenuBlock, ;
               aItem[ 2 ], ;
               aItem[ 3 ], ;
               aitem[ 4 ]  )
            oSubMenu:addItem ( oItem )

        NEXT
        oItem := MenuItem():new( hElement:__enumKEY , oSubMenu )
        oMainMenu:AddItem( oItem )
    NEXT

	// Aqui é o laço principal  
    nOpc := 1
    DO WHILE .T.
        nOpc := MenuModal( oMainMenu, INT( nOpc / 10 ), ;
           MaxRow(), 0, MaxCol(), ;
           oMainMenu:colorSpec )
        /*   
         Aqui você deve alterar para pegar o retorno
         e chamar as suas rotinas 
         Note que o valor de retorno foi definido na criação
         das opções do menu 
     
        */   
        ? nOpc 
        DO CASE
        CASE nOpc == -1 
        	ExitRoutine()
        CASE nOpc == 14 
        	ExitRoutine()
        CASE nOpc == 21 
        	Alert("Substitua pela sua rotina") // Sua rotina aqui 
        OTHERWISE

        ENDCASE
    ENDDO

    RETURN 

PROCEDURE ExitRoutine

    IF Alert( "Exit program?", { "Yes", "No" } ) == 1
        QUIT
    ENDIF

    RETURN

