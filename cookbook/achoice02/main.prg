#include "inkey.ch"
#include "hbgtinfo.ch"
#include "achoice.ch"
procedure main
	// testing LastKey after aChoice
	local cScreen, nChoice
	setmode (25,80)
	//SETINKEYAFTERBLOCK({|nKey|nafterinkey(nKey)}) ->xHarbour
	//hb_gtInfo(HB_GTI_INKEYFILTER, {|nKey|nafterinkey(nKey)})
	
	private lDoubleClick:=.f., aOptions
   Clear Screen
   aOptions={'1. One','2. Two','3. Three','4. Four','5. Five','0. Exit'}
   SET( _SET_EVENTMASK, INKEY_ALL-INKEY_MOVE )
   do while nChoice<>6
      nChoice := aChoice(10,10, 20,30, aOptions,,"MyFn")
      if lDoubleclick
				lDoubleclick=.f.
				alert ("You pressed double click on "+aOptions[nChoice])
			else
				ALERT(aOptions[nChoice]+" selected by ENTER")
			endif
   enddo
return nil

function myFn(nMode,nItem,nRowpos)
	local nRetval:=AC_CONT
	@ 12,60 say "nMode:       "+alltrim(str(nMode)) COLOR 'B/W'
	IF nMode == AC_EXCEPT
		if lDoubleclick
			@ 13,50 say "Item clicked:"+alltrim(aOptions[nItem]) COLOR 'B/W'
			nRetval=AC_SELECT
		endif
		if lastkey()=K_ENTER
			nRetVal=AC_SELECT
		endif
	endif
RETURN nRetval