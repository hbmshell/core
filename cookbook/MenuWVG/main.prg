//https://groups.google.com/g/harbour-users/c/6555F0uOAs0
MEMVAR m_Prog, nMenuLevel, oMenuOptions

PROCEDURE Main

   LOCAL aMenuList := MenuList()

   SetMode(40,100)
   CLS
   MenuWvg( aMenuList )
   Inkey(0)

   RETURN

PROCEDURE HB_GTSYS

   REQUEST HB_GT_WVG_DEFAULT

   RETURN
   // Pra rotina de erros do José

FUNCTION AppVersaoExe(); RETURN ""

STATIC FUNCTION MenuWvg( mMenuOpt )

   LOCAL oMenu, nKey

   oMenu  := wvgSetAppWindow():MenuBar()
   BuildMenu( oMenu, mMenuOpt )
   DO WHILE .T.
      nKey := Inkey(0)
      DO CASE
      CASE nKey == HB_K_GOTFOCUS
      CASE nKey == HB_K_LOSTFOCUS
      CASE nKey == K_ESC
         EXIT
      ENDCASE
   ENDDO
   wvgSetAppWindow():oMenu := NIL
   wapi_SetMenu( wapi_GetActiveWindow(), NIL )
   wapi_DestroyMenu( oMenu:hWnd )

   RETURN NIL

FUNCTION BuildMenu( oMenu, acMenu )

   LOCAL oElement, oSubMenu, cbCode, m_ProgTxt

   FOR EACH oElement IN acMenu
      IF Len( oElement[ 2 ] ) == 0
         m_Prog := oElement[ 3 ]
         IF ValType( m_Prog ) == "C"
            m_ProgTxt := "( " + m_Prog + ") " + Upper( oElement[ 1 ] )
            cbCode     := [{ || RunModule( "] + m_Prog + [", "] + m_ProgTxt + [" ) }]
            oMenu:AddItem( oElement[ 1 ] , &( cbCode ) )
         ELSE
            oMenu:AddItem( oElement[ 1 ], oElement[ 3 ] )
         ENDIF
      ELSE
         oSubMenu := WvgMenu():new( oMenu, , .T. ):Create()
         BuildMenu( oSubMenu, oElement[ 2 ] )
         oMenu:AddItem( oSubMenu, oElement[ 1 ] )
      ENDIF
   NEXT

   RETURN NIL

FUNCTION MenuList()

   nMenuLevel   := 0
   oMenuOptions := {}

   MenuOption( "Faturamento" )
      MenuDrop()
      MenuOption( "Pedidos/Notas/Manifesto" )
         MenuDrop()
         MenuOption( "Orçamentos/Pedidos",                   "PJPPEDIDO" )
         MenuOption( "Orçamentos/Pedidos SubOpções" )
            MenuDrop()
            MenuOption( "(I)Ped.Cancelamento",               "ADMPEDCAN" )
            MenuOption( "(I)Reemite Cupom pra Pedido",       "PJPPEDIDOCUPOM" )
            MenuOption( "(I)Ped.Duplicar Pedidos",           "ADMPEDCLO" )
           MenuUndrop()
         MenuUndrop()
      MenuUnDrop()
   MenuOption( "Faturamento" )
      MenuDrop()
      MenuOption( "Pedidos/Notas/Manifesto" )
         MenuDrop()
         MenuOption( "Orçamentos/Pedidos",                   "PJPPEDIDO" )
         MenuOption( "Orçamentos/Pedidos SubOpções" )
            MenuDrop()
            MenuOption( "(I)Ped.Cancelamento",               "ADMPEDCAN" )
            MenuOption( "(I)Reemite Cupom pra Pedido",       "PJPPEDIDOCUPOM" )
            MenuOption( "(I)Ped.Duplicar Pedidos",           "ADMPEDCLO" )
           MenuUndrop()
         MenuUndrop()
      MenuUnDrop()
   MenuOption( "Faturamento" )
      MenuDrop()
      MenuOption( "Pedidos/Notas/Manifesto" )
         MenuDrop()
         MenuOption( "Orçamentos/Pedidos",                   "PJPPEDIDO" )
         MenuOption( "Orçamentos/Pedidos SubOpções" )
            MenuDrop()
            MenuOption( "(I)Ped.Cancelamento",               "ADMPEDCAN" )
            MenuOption( "(I)Reemite Cupom pra Pedido",       "PJPPEDIDOCUPOM" )
            MenuOption( "(I)Ped.Duplicar Pedidos",           "ADMPEDCLO" )
           MenuUndrop()
         MenuUndrop()
      MenuUnDrop()
   MenuOption( "Faturamento" )
      MenuDrop()
      MenuOption( "Pedidos/Notas/Manifesto" )
         MenuDrop()
         MenuOption( "Orçamentos/Pedidos",                   "PJPPEDIDO" )
         MenuOption( "Orçamentos/Pedidos SubOpções" )
            MenuDrop()
            MenuOption( "(I)Ped.Cancelamento",               "ADMPEDCAN" )
            MenuOption( "(I)Reemite Cupom pra Pedido",       "PJPPEDIDOCUPOM" )
            MenuOption( "(I)Ped.Duplicar Pedidos",           "ADMPEDCLO" )
           MenuUndrop()
         MenuUndrop()
      MenuUnDrop()
   MenuOption( "Faturamento" )
      MenuDrop()
      MenuOption( "Pedidos/Notas/Manifesto" )
         MenuDrop()
         MenuOption( "Orçamentos/Pedidos",                   "PJPPEDIDO" )
         MenuOption( "Orçamentos/Pedidos SubOpções" )
            MenuDrop()
            MenuOption( "(I)Ped.Cancelamento",               "ADMPEDCAN" )
            MenuOption( "(I)Reemite Cupom pra Pedido",       "PJPPEDIDOCUPOM" )
            MenuOption( "(I)Ped.Duplicar Pedidos",           "ADMPEDCLO" )
           MenuUndrop()
         MenuUndrop()
      MenuUnDrop()

   RETURN oMenuOptions

STATIC FUNCTION MenuOption( cCaption, cModule, bCode )

   LOCAL nCont, oLastMenu

   oLastMenu := oMenuOptions
   FOR nCont = 1 TO nMenuLevel
      oLastMenu := oLastMenu[ Len( oLastMenu ) ]
      oLastMenu := oLastMenu[ 2 ]
   NEXT
   AAdd( oLastMenu, { cCaption, {}, cModule, bCode, 1 } )

   RETURN NIL

STATIC FUNCTION MenuDrop()

   nMenuLevel++

   RETURN NIL

STATIC FUNCTION MenuUnDrop()

   nMenuLevel--

   RETURN NIL

FUNCTION RunModule( cName, cTitle )

   LOCAL xTela

   SAVE SCREEN TO xTela
   CLS
   @ 0, 0 SAY cTitle
   @ 1, 0 TO 1, MaxCol()
   @ MaxRow()-1, 0 TO MaxRow()-1, MaxCol()
   Alert( "Module " + cName )
   // DO( cName )
   RESTORE SCREEN FROM xTela

   RETURN Nil