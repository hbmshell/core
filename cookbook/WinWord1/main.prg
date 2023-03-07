// https://support.microsoft.com/en-us/office/update-fields-7339a049-cb0d-4d5a-8679-97c20c643d4e#:~:text=Press%20Ctrl%20%2B%20A.,update%20fields%20automatically%20before%20printing.
//https://groups.google.com/g/harbour-users/c/Qv6GU-YXGR8
PROCEDURE Main

   LOCAL oWord, oText

   IF (oWord := win_oleCreateObject("Word.Application")) <> NIL

      oWord:Documents:Add()
      oWord:Visible := .T.
      oWord:ActiveDocument:select()
      oText := oWord:Selection()
      oRange := oText:Range()
      oTable := oText:Tables:Add(oRange, 3, 4)
      oTable:AutoFormat()
      oTable:Cell(1,1):Range:Text := 1110
      oTable:Cell(2,1):Range:Text := 222
      oTable:Cell(3,1):Formula("=A1+A2")

   ELSE

      ? "Error."

   ENDIF


RETURN