PROCEDURE HBM_40checkbox

    LOCAL lOpt1 := .f.
    LOCAL lOpt2 := .t.
    LOCAL lOpt3 := .f.
    
    CLS
    @ 08,10 GET lOpt1 CHECKBOX CAPTION "Harbour" COLOR  "W/B+,W/B,W+/R,W/G+"
    @ 10,10 GET lOpt2 CHECKBOX CAPTION "Meu T�tulo" COLOR  "W/B+,W/B,W+/R,W/G+" VALID IIF( lOpt1 , .t. , ( hb_alert("Harbour option must be checked") , .f.) )
    @ 12,10 GET lOpt3 CHECKBOX CAPTION "My Title" COLOR  "W/B+,W/B,W+/R,W/G+"
    READ

    @ 14,10 SAY lOpt1
    @ 16,10 SAY lOpt2
    @ 18,10 SAY lOpt3

  
    
RETURN