//....................................................................
//
//   Program Name: HELP.PRG          Copyright: BrayWorth Pty Ltd
//   Date Created: 03/14/95          Author   : David Bray
//                                   Telephone: (0011) (075) 982108
//   Note: Tab Stops := 9
//
//   Compile Clipper help /n/w
//   Link    RTLink  File Help
//      or   Blinker File Help
//....................................................................

/*

	:Hi:

To:
All who want on-line help !

From:
David Bray
Clipper Programmer
Brayworth Pty Ltd
PO Box 132 Palm Beach Queensland Australia 4221
Tel/Fax International 64-75-982108
Compuserve  100032,23

	:OverView:

    On Line Documentation
    ---------------------

This utility program will put your selected reference at the top of
the screen using memoedit().

I recently purchased a hypertext product for no other reason than to
create my own Nortons Guides.  After converting the documentation
from Word-Perfect (some time earlier it was converted from Wordstar),
hyperlinks were created and, after showing off the finished product
to a programming buddy, I was pleased to receive a pat on the back.

It looked and worked superbly and in my next installation I
faithfully installed the product, and showed them client how to use
it. The client was also supplied with the printed manual for good
measure.

After one month I re-attended the site for a standard follow up
visit. They had lost the manual and forgotten about the hypertext,
fortunately they were still using the program !!

So what do you do ?

The Task
--------

To have on-line help, and, without re-typing a sinlge line of the
manual, have the option to supply a printed manual.

The Answer
----------

There is only one text format - ASCII.
    No other text format is universally acceptable.

The help must be available as a menu option so the user can see it,
therefore it must be part of the clipper program.

The text must be printable, and the simpler the printing process the
better, preferably;
    "Copy Manual.Txt LPT1".

The Text can also read into most word-processors for quick formating
and printing.

The Method
----------

Create a straight ASCII text file. Memoedit is an Ok editor (Brief is
better), it is best to replace the soft Carriage Returns with Hard
ones.

Put References in the text, I like to add a colon prefix and suffix
to references to make them unique, something like this;

    :Suppliers File:

    The Suppliers file holds suppliers !!

Add the activation code to your program

    Proc SupplierEnquiry()

        local bF1   :=  ;
            SetKey( K_F1,    ;
                { || Manual( ':Suppliers File:' )   ;
            } )

        // do your stuff clipper programmer

        setkey( K_F1, bF1 )
    Return

Create the memoedit positioning utility (this example was created
from sample models in pe.prg)

	:Code:
//..........................................
//
//   Program Name: MANUAL.PRG
//   Author      : David Bray
//
//...........................	*/

#include 'inkey.ch'

static cFile    := 'manual.txt'

//		:Demo:

proc demo
	local cManual	:= manualSET( 'Help.Prg' )
	local bKF1	:= setkey( K_F1, { || manual( ':Hi:' )		})
	local bKF2	:= setkey( K_F2, { || manual( ':OverView:' )	})
	local bKF5	:= setkey( K_F5, { || manual( ':Code:' )	})
	local bKF6	:= setkey( K_F6, { || manual( ':Demo:' )	})
	local bKF7	:= setkey( K_F7, { || manual( ':Manual Change' + ':')})
	local bKF8	:= setkey( K_F8, { || manual( ':Reference' + ':' )	})

	cls

	? "     Press F1, I'll say Hi"
	? "     Press F2, See the Overview"
	?
	?
	?
	? "     Press F5, See the Code"
	? "         Press F6, See the Demo"
	? "         Press F7, See how the change the manual"
	? "         Press F8, See how the to look up reference"
	?
	?

	wait

	setkey( K_F8,bKF8 )
	setkey( K_F7,bKF7 )
	setkey( K_F6,bKF6 )
	setkey( K_F5,bKF5 )
	setkey( K_F2,bKF2 )
	setkey( K_F1,bKF1 )
	manualSET( cManual )
return

//		:Manual Change:

func manualSET( cNew )

    //  function for setting and resetting help file
    local cRet    := cFile

    if cNew != nil
        cFile    := cNew
    end
return ( cRet )

//		:Reference:'

proc manual( cRef )

    local t         := 0
    local l         := 0
    local b         := maxrow()
    local r         := maxcol()
    local aRC       := { row(), col() }
    local cScreen   := savescreen()
    local lEdit     := .t.  // .f. on the
                            // distributed version
    local nWidth    := 77
    local nRow      := 1
    local nCol      := 0
    local nPos      := 0

    // turn cursor on as a positioning aid
    local nCursor   := setcursor( 1 )

    local cColor    := setcolor( 'W/B' )
    local cHead     := '[Manual Enquiry]'
    local cText, cNew, aLC

    cls
    @ t,l to b,r
    @ t,(r-l-len(cHead))/2 say cHead

    // read in the file ...
    cText   := memoread( cFile )
    if cRef != nil
        // locate the reference
        nPos    := at( cRef, cText )

        if nPos > 0
        // what line and column is that in the text ?
            aLC     := MPosToLC( cText,nWidth,nPos )
            nRow    := aLC[ 1 ]
            nCol    := aLC[ 2 ]
        endif
    endif

    cNew := memoedit(   cText,              ;
                        t+1,l+1,b-1,r-1,    ;
                        lEdit,,nWidth,,     ;
                        nRow, nCol, 0, nCol )

    if lEdit .and. !( cNew == cText )
        // remove soft returns before saving
        memowrit( cFile, hardcr( cNew ) )
    end

    Restscreen( ,,,,cScreen )
    setcursor( nCursor )
    setcolor( cColor )
    setpos( aRC[1],aRC[2] )
return



