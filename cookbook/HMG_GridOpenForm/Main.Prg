
//-q0
//-I.
Function hb_Main

        Load Window Main
        Main.Center
        Main.Activate

Return

//Declare Window Main

Procedure Buscar()

	doMethod( "Main" , "Grid_Busca" , "DELETEALLITEMS" )
	
	doMethod( "Main" , "Grid_Busca" , "ADDITEM" , { "Vlademiro" , "R. Brasil" } )
	doMethod( "Main" , "Grid_Busca" , "ADDITEM" , { "Teresa" , "R. Cristina" } )

Return

Procedure DuploClick()

    LOCAL nRow := Main.Grid_Busca.Value

	MsgInfo( hb_StrFormat( "Double click in %d" , nRow )  )

        Load Window MyForm

	SetProperty( "MyForm" , "MyLabel" , "Value" , nRow )


        MyForm.Center
        MyForm.Activate

	
Return
