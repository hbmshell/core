#include "button.ch"
#include "inkey.ch"
REQUEST HB_CODEPAGE_PTISO
REQUEST HB_CODEPAGE_UTF8
PROCEDURE  hb_Main(...)

    LOCAL oMainMenu  
    LOCAL bMenuBlock := {||NIL} 
    LOCAL cMenuColor := "N/BG,W+/R,GR+/BG,GR+/R,N+/BG,N/BG"
    LOCAL hElement, hMenu, hElem1
    LOCAL aItem, oItem, oSubMenu
    LOCAL nOpc
    LOCAL hJson 
    LOCAL aRoutine := {}

	CLS 
    hb_cdpselect("UTF8")
   
    /*
    Ítens
    */
    hJson := hb_JsonDecode( hb_MemoRead( "config.json" ) )
    hMenu := {=>}   
    hElement := NIL
    FOR EACH hElem1 IN hJson["menu"]
        aMenu := {}
        hElem2 := NIL
        FOR EACH hElem2 IN hElem1
            AADD( aRoutine , hElem2["routine"] )
            AADD( aMenu , { hElem2["caption"] , NIL , hElem2["message"] , LEN( aRoutine ) } )
        NEXT
        hMenu[ hElem1:__enumkey() ] := aMenu
    NEXT
    
   
    /*
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

*/

    
	// Aqui o menu é montado  
    HB_CdpSelect("PTISO")
    oMainMenu  := HBTopBarMenu():new( 0, 0, MaxCol() )
    HB_CdpSelect("UTF8")
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
        nOpc := MenuModal( oMainMenu, Int( nOpc / 10 ), ;
           MaxRow(), 0, MaxCol(), ;
           oMainMenu:colorSpec )
        /*   
         Aqui você deve alterar para pegar o retorno
         e chamar as suas rotinas 
         Note que o valor de retorno foi definido na criação
         das opções do menu 
     
        */   
        ? nOpc 
        IF nOpc == -1
            IF Alert( "Sair do programa ?", { "Sim", "Não" } ) == 1
                EXIT
            ENDIF
            nOpc := 1
	    LOOP
        ENDIF
        ? "Executando " , aRoutine[ nOpc ]
        
        
    ENDDO

    RETURN 

PROCEDURE ExitRoutine

    

    RETURN

