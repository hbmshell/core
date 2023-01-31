#include <hmg.ch>

Function Main

    Load Window Main
    Main.Center
    Main.Activate

Return


Function Child

    Load Window Child
    Child.Label_1.Value := "Window parent name : " + ShowParentName()  
    Child.Center
    Child.Activate
        

Return

Function BeforeActivate()

    Child.Label_2.Value := "Window parent name : " + ShowParentName()

    Return    

Function ShowParentName()

    LOCAL hWnd := GetActiveWindow(), hWndParent := GetParent(hWnd), cWindowName    
          
    GetFormNameByHandle (hWndParent, @cWindowName)

//    MsgDebug(cWindowName)  
      
Return (cWindowName)

