
#include <hmg.ch>
Function hb_Main


OpenTables()

    DEFINE WINDOW Win_1 ;
        AT 0,0 ;
        WIDTH 640 HEIGHT 480 ;
        TITLE 'Tutor 20: GRID Test' ;
        MAIN NOMAXIMIZE 

        DEFINE MAIN MENU 
            POPUP 'File'
                ITEM 'Set Grid RecNo' ACTION Win_1.Grid_1.Value := Val ( InputBox ('Set Grid RecNo','') )
                ITEM 'Get Grid RecNo' ACTION MsgInfo ( Str ( Win_1.Grid_1.RecNo ) )
                SEPARATOR
                ITEM 'Exit' ACTION Win_1.Release
            END POPUP
            POPUP 'Help'
                ITEM 'About' ACTION MsgInfo ("Tutor 20: GRID Test") 
            END POPUP
        END MENU

        @ 10,10 GRID Grid_1 ;
            WIDTH 610 ;
            HEIGHT 390 ; 
            HEADERS { 'Code' , 'First Name' , 'Last Name', 'Birth Date', 'Married' , 'Biography' } ;
            WIDTHS { 150 , 150 , 150 , 150 , 150 , 150 } ;
            ROWSOURCE "Test" ;
            COLUMNFIELDS { 'Code' , 'First' , 'Last' , 'Birth' , 'Married' , 'Bio' } ;
            COLUMNCONTROLS {{'TEXTBOX','NUMERIC','999'},{'TEXTBOX','CHARACTER'},{'TEXTBOX','CHARACTER'},{'TEXTBOX','DATE'},{'CHECKBOX'},{'TEXTBOX','CHARACTER'}};
            ALLOWDELETE ;
            EDIT

    END WINDOW

    CENTER WINDOW Win_1

    ACTIVATE WINDOW Win_1

Return Nil

Procedure OpenTables()

    LOCAL aFields := {}
    
    aadd( aFields , { "Code" , "N" , 3 , 0 } )
    aadd( aFields , { "First" , "C" , 30 , 0 } )
    aadd( aFields , { "Last" , "C" , 30 , 0 } )
    aadd( aFields , { "Birth" , "D" , 8 , 0 } )
    aadd( aFields , { "Married" , "L" , 1 , 0 } )
    aadd( aFields , { "Bio" , "M" , 10 , 0 } )
    
    dbCreate( "Test.dbf" , aFields )
    Use Test
    For x := 1 TO 50
        append blank
        replace code with x
        replace first with "Jonathan " + hb_ntos( x )
        replace last with "Habito" 
        replace birth with date()-hb_randomint( 10000, 50000 )
        replace married with iif( mod(x,2)==0,.t.,.f.)
        replace bio with "Biographi bla bla bla"
    Next
//    Win_1.Grid_1.RecNo := RecNo() 
Return Nil

