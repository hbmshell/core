/**
To build
--------

hbmk2 main.prg 

Thanks!
https://vivaclipper.wordpress.com/tag/directory/

*/
PROCEDURE Main
   
         LOCAL aFFList := HB_DirScan( "../../" )

         LOCAL x1Row

         FOR EACH x1Row IN aFFList
            ? PAD( x1Row[ 1 ], 23 ),;                     // Name
              TRAN( x1Row[ 2 ], '999,999,999,999' ),;     // Size
              x1Row[ 3 ],;                                // Date
              x1Row[ 4 ],;                                // Time
              x1Row[ 5 ]                                  // Attributes
         NEXT x1Row

RETURN


