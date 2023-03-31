/**

To build : hbmk2 main.prg 


*/

PROCEDURE Main

    LOCAL hJson := { => }
    
    hJson[ "Name" ] := "Rosemberg Alexander"
    hJson[ "Date" ] := Date()
    hJson[ "Salary" ] := 123000
    hJson[ "Status" ] := .t.
    
    ? "Original : " , hb_ValToExp( hJson )
    
    ? "Converted to string json : " , hb_JsonEncode( hJson )

RETURN
