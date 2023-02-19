// http://www.pctoledo.com.br/forum/viewtopic.php?f=1&t=25623
PROCEDURE Main

   LOCAL nValor
   LOCAL nItem
   
   INPUT "Insert value : " TO nValor

   FOR EACH nItem IN Troco( nValor )
      ? Str( nItem[ 1 ], 2 ) + " " + iif( nItem[ 1 ] < 2, "coin(s)", "bill(s)" ) + " of " + Str( nItem[ 2 ] )
   NEXT
   Inkey(0)

   RETURN

FUNCTION Troco( nValor )

   LOCAL aList := { 200, 100, 50, 20, 10, 5, 2, 1, 0.50, 0.25, 0.10, 0.05, 0.01 }
   LOCAL aTroco := {}
   LOCAL nItem, nQtd

   nValor := Int( nValor * 100 )
   FOR EACH nItem IN aList
     nQtd := Int( nValor / ( nItem * 100 ) )
     //? nValor/100, nItem, nQtd
     IF nValor >= ( nItem * 100 )
        nValor := nValor - ( nQtd * nItem * 100 )
        AAdd( aTroco, { nQtd, nItem } )
     ENDIF
   NEXT

   RETURN aTroco