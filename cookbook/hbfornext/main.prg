//Thanks
//https://vivaclipper.wordpress.com/2014/02/20/hb_fornext/
PROCEDURE Main
 HB_ForNext( 1, 10, { | i1 | QQOUT( STR( i1, 3 ) ) } )

           ?

           aDays := ADays()

            HB_ForNext( 1, LEN( aDays ), { | i1 | QOUT( i1, aDays[ i1 ] ) } )

           ?
   
   
RETURN 


