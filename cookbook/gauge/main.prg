//
PROCEDURE MAIN

LOCAL  aGauge := GaugeNew( 20, 15, 22, 50, "W/B", "W+/B", chr(219) )
LOCAL  nTot := 575, nPos

    GaugeDisplay( aGauge )
    FOR nPos := 1 TO nTot

       GaugeUpdate( aGauge, nPos / nTot )


    NEXT    

RETURN   
//---------------------------------------------------------------------------------
#include "box.ch"
// Box array definitions
#define B_LEN           9
#define B_TOP           1
#define B_LEFT          2
#define B_BOTTOM        3
#define B_RIGHT         4
#define B_BACKCOLOR     5
#define B_BARCOLOR      6
#define B_DISPLAYNUM    7
#define B_BARCHAR       8
#define B_PERCENT       9

#define B_BOXLINES      B_SINGLE
//---------------------------------------------------------------------------------
/***
*  GaugeNew( , , , ,
*     [],
*     [],
*     [] ) --> aGauge
*
*  Create a new gauge array
*
*/
FUNCTION GaugeNew( nTop, nLeft, nBottom, nRight, ;
                 cBackColor, cBarColor, cBarCharacter )

   LOCAL aHandle[ B_LEN ]     // Contains info about the gauge

   // Assign default values
   aHandle[ B_TOP ]        := nTop
   aHandle[ B_LEFT ]       := nLeft
   aHandle[ B_BOTTOM ]     := nBottom
   aHandle[ B_RIGHT ]      := nRight
   aHandle[ B_BACKCOLOR ]  := "W/N"
   aHandle[ B_BARCOLOR ]   := "W+/N"
   aHandle[ B_DISPLAYNUM ] := .T.
   aHandle[ B_BARCHAR ]    := CHR( 219 )
   aHandle[ B_PERCENT ]    := 0

   // Resolve parameters
   IF cBackColor <> NIL
      aHandle[ B_BACKCOLOR ] := cBackColor
   endif

   IF cBarColor <> NIL
      aHandle[ B_BARCOLOR ] := cBarColor
   endif

   IF cBarCharacter <> NIL
      aHandle[ B_BARCHAR ] := cBarCharacter
   endif

   // OK, the defaults are set, now let's make sure it will fit on the
   // screen correctly
   IF aHandle[ B_RIGHT ] < aHandle[ B_LEFT ] + 4
      aHandle[ B_RIGHT ] := aHandle[ B_LEFT ] + 4
   endif

   IF aHandle[ B_BOTTOM ] < aHandle[ B_TOP ] + 2
      aHandle[ B_BOTTOM ] := aHandle[ B_TOP ] + 2
   endif

   // Determine if we can fit the bracketed number on top of the graph
   IF aHandle[ B_RIGHT ] < aHandle[ B_LEFT ] + 9
      aHandle[ B_DISPLAYNUM ] := .F.
   endif

   return( aHandle )

/***
*
*  GaugeDisplay( aGauge ) --> aGauge
*
*  Display a gauge array to the screen
*
*/
FUNCTION GaugeDisplay( aHandle )

   LOCAL nCenter   := ROUND( (aHandle[B_RIGHT] - aHandle[B_LEFT]) / 2, 0) + 1
   LOCAL cOldColor := SETCOLOR( aHandle[ B_BACKCOLOR ] )

   @ aHandle[ B_TOP ], aHandle[ B_LEFT ] CLEAR TO ;
     aHandle[ B_BOTTOM ], aHandle[ B_RIGHT ]

   @ aHandle[ B_TOP ], aHandle[ B_LEFT ], ;
     aHandle[ B_BOTTOM ], aHandle[ B_RIGHT ] BOX B_BOXLINES

   IF aHandle[ B_DISPLAYNUM ]
      @ aHandle[ B_TOP ], nCenter SAY "[      ]"
   endif

   SETCOLOR( cOldColor )

   // Draw bar to show current percent
   GaugeUpdate( aHandle, aHandle[ B_PERCENT ] )

   return( aHandle )

/***
*
*  GaugeUpdate( aGauge, nPercent ) --> aGauge
*
*  Updates a gauge with a new progress value and redisplays the gauge
*  to the screen to the screen
*
*/
FUNCTION GaugeUpdate( aHandle, nPercent )

   LOCAL nCenter   := ROUND( (aHandle[B_RIGHT] - aHandle[B_LEFT]) / 2, 0) + 1
   LOCAL cOldColor := SETCOLOR( aHandle[ B_BARCOLOR ] )
   LOCAL nBarRatio := (aHandle[ B_RIGHT ]) - (aHandle[ B_LEFT ] + 1)
   LOCAL nRow      := 0
   LOCAL nCols     := 0

   IF aHandle[ B_DISPLAYNUM ]
      @ aHandle[ B_TOP ], nCenter + 2 SAY STR( nPercent * 100, 3 ) + "%"
   endif

   IF nPercent > 1
      nPercent := 1
   endif

   IF nPercent < 0
      nPercent := 0
   endif

   nCols := ROUND( nPercent * nBarRatio, 0 )

   @ aHandle[ B_TOP ] + 1, aHandle[ B_LEFT ] + 1 CLEAR TO ;
     aHandle[ B_BOTTOM ] - 1, aHandle[ B_RIGHT ] - 1

   FOR nRow := 1 TO (aHandle[ B_BOTTOM ] - aHandle[ B_TOP ] - 1)
      @ nRow + aHandle[ B_TOP ], aHandle[ B_LEFT ] + 1 SAY ;
        REPLICATE( aHandle[ B_BARCHAR ], nCols )
   NEXT

   SETCOLOR( cOldColor )

return( aHandle )

