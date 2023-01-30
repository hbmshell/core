
//-q0
//-I.
Function hb_Main

        Load Window Main
        Main.Center
        Main.Activate

Return

Declare Window Main

Procedure Buscar()

	doMethod( "Main" , "Grid_Busca" , "DELETEALLITEMS" )
	
	doMethod( "Main" , "Grid_Busca" , "ADDITEM" , { "Vlademiro" , "R. Tereza Cristina" } )

Return
