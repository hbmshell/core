#include "inkey.ch"
PROCEDURE Hbm_gsheet()
    local cFormula

    cFormula := "=INDIRECT(ADDRESS(ROW();COLUMN()-1))*INDIRECT(ADDRESS(ROW();COLUMN()-2))"
    // cFormula := '=INDIRECT("R[0]C[-1]";FALSE)*INDIRECT("R[0]C[-2]";FALSE)'
    
   
    OutStd( "Samples" + Chr(K_TAB) + ;
                "Val1 " + Chr(K_TAB) + ;
                "Val 2" + Chr(K_TAB) + ;
                'Product' , hb_Eol() )

    FOR x := 4 TO 550 STEP 2
        
        OutStd( "Sample " + hb_ntos( x ) + Chr(K_TAB) + ;
                            hb_ntos( hb_RandomInt(1,2000) ) + Chr(K_TAB) + ;
                            hb_ntos( hb_RandomInt(1,2000) ) + Chr(K_TAB) + ;
                            cFormula, hb_eol() )

    NEXT

   
RETURN
