

PROCEDURE Main

     LOCAL cStr := Memoread( "model.rtf" )
     LOCAL cOut
     
     ? "Template: model.rtf"
     ? "Replacing <<Name>> to 'Smith'"
     ? "See out.rtf"

     cOut := StrTran( cStr , "<<Name>>" , "Smith" )

     MemoWrit( "out.rtf" , cOut )


     RETURN
