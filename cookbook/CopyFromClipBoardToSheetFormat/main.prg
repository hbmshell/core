
PROCEDURE Hbm_gsheet( ... )
   
    y=0
    WriteLN "Samples" + Chr(K_TAB) + ;
                "Val1 " + Chr(K_TAB) + ;
                "Val 2" + Chr(K_TAB) + ;
                'Product'

    FOR x := 4 TO 550 STEP 2
        WriteLN "Sample " + hb_ntos( x ) + Chr(K_TAB) + ;
                            hb_ntos( hb_RandomInt(1,2000) ) + Chr(K_TAB) + ;
                            hb_ntos( hb_RandomInt(1,2000) ) + Chr(K_TAB) + ;
                            '=INDIRECT("R[0]C[-1]",FALSE)*INDIRECT("R[0]C[-2]",FALSE)'

    NEXT

   
RETURN
