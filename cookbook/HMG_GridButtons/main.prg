#include <hmg.ch>
Function Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 580 ;
		HEIGHT 400 ;
		TITLE 'Hello World!' ;
		MAIN

		DEFINE GRID Grid_1 
			ROW		10
			COL		10
			WIDTH		550 
			HEIGHT		330 
			HEADERS		{'...','Last Name','First Name','Phone','...'} 
			WIDTHS		{20,140,140,140,20}
			ITEMS		LoadItems() 
            ONDBLCLICK DuploClick()
			VALUE		5
			IMAGE		{ '00.bmp' ,'01.bmp' , '02.bmp' , '03.bmp' , '04.bmp' , '05.bmp' , '06.bmp' , '07.bmp' , '08.bmp' , '09.bmp' }
	        JUSTIFY		{ GRID_JTFY_LEFT,GRID_JTFY_CENTER, GRID_JTFY_CENTER, GRID_JTFY_CENTER,GRID_JTFY_LEFT } 
		END GRID

	END WINDOW

	Form_1.Center

	Form_1.Activate

Return


Procedure DuploClick()

/*
    LOCAL nRow := Main.Grid_Busca.Value
    
    MsgInfo( Main.FocusedControl )
    MsgInfo( GetControlType(( Main.FocusedControl ), 'Main') )
	MsgInfo( hb_StrFormat( "Duplo click em %d" , nRow )  )
*/

MSGINFO("OK")

Return

Function LoadItems()
Local aRows [20] [4]

	aRows [1]	:= {0,'Simpson','Homer','555-5555',2}
	aRows [2]	:= {1,'Mulder','Fox','324-6432',2}
	aRows [3]	:= {2,'Smart','Max','432-5892',2}
	aRows [4]	:= {3,'Grillo','Pepe','894-2332',2}
	aRows [5]	:= {4,'Kirk','James','346-9873',2} 
	aRows [6]	:= {5,'Barriga','Carlos','394-9654',2} 
	aRows [7]	:= {6,'Flanders','Ned','435-3211',2} 
	aRows [8]	:= {7,'Smith','John','123-1234',2} 
	aRows [9]	:= {8,'Pedemonti','Flavio','000-0000',2} 
	aRows [10]	:= {9,'Gomez','Juan','583-4832',2} 
	aRows [11]	:= {0,'Fernandez','Raul','321-4332',2} 
	aRows [12]	:= {1,'Borges','Javier','326-9430',2}
	aRows [13]	:= {2,'Alvarez','Alberto','543-7898',2}
	aRows [14]	:= {3,'Gonzalez','Ambo','437-8473',2}
	aRows [15]	:= {4,'Batistuta','Gol','485-2843',2}
	aRows [16]	:= {5,'Vinazzi','Amigo','394-5983',2}
	aRows [17]	:= {6,'Pedemonti','Flavio','534-7984',2}
	aRows [18]	:= {7,'Samarbide','Armando','854-7873',2}
	aRows [19]	:= {8,'Pradon','Alejandra','???-????',2}
	aRows [20]	:= {9,'Reyes','Monica','432-5836',2}

Return aRows





