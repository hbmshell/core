/*

   Grumpfish Library demo for CA-Clipper 5.x
   Author: Greg Lief
   Copyright (c) 1988-93, Greg Lief
   Compile instructions: clipper demo /n /w
   Link instructions:    rtlink fi demo li grump
                                  - or -
                         blinker fi demo li grump

   If you want mouse support, compile with "/dMOUSE" and be sure to
   link in either GRUMPM.LIB (5.01) or GRUMP52M.LIB (5.2)

*/

external soundex

#include "apick.ch"
#include "abrowse.ch"
#include "grump.ch"
#include "grumpbro.ch"
#include "grumpind.ch"
#include "grumpr.ch"
#include "grumpm.ch"
#include "inkey.ch"

#define PRIMARY_COLOR    "W/RB"

//ÄÄÄÄÄ the next two static variables are used only for the trick
//ÄÄÄÄÄ highlighting during the @..GGET demo
static ptr
static verbiage_ := { ;
[@ 14,0 gget v math message "Enter a math formula"], ;
[@ 15,0 gget y calculator cursor pict '#####.##' message "Right-to-left entry"], ;
[@ 16,0 gget team list teams message "Use spacebar or backspace to toggle"], ;
[@ 17,0 gget w step color 'n/bg,+w/r' message "Use + and - keys"], ;
[@ 18,0 gget pass1 message "Enter a password" password "?"], ;
[@ 19,0 gget pass2 message "Enter a password" password], ;
[@ 20,0 gget z proper message "This will be proper-case"], ;
[@ 21,0 gget x array days picture '@!' message "Please pick a day!"] }

static nMidrow

function main(skip_it)
local selected
local maincolor
local cDOSscreen := '!!!!!!!!.!!!'
local mrow
local mtone
local cScrnFile
local msg := "Grumpfish Library 4.0"
setblink(.f.)
colorinit('colors.gf')
setcursor(0)
set scoreboard off
set wrap on
save_drape(cDOSscreen)
selected := 'i'
nMidrow := maxrow() / 2
if int(nMidrow) <> nMidrow
   nMidrow++
endif
if skip_it == NIL
   setcolor('+W/N')
   scroll()
   Fallguy(03, 29, msg, 100)
   scrncenter(maxrow(), 'Press space bar for demo or Esc for DOS', '+BR/N')
   #ifdef MOUSE
   SetMousePos(3, 30)
   ShowMouseCursor()
   #endif
   rainbow(msg)
   #ifdef MOUSE
   HideMouseCursor()
   if lastkey () <> K_ESC .and. lastkey() <> K_RIGHT_DOWN
   #else
   if lastkey () <> K_ESC
   #endif
      lets_go()
   endif
else
   lets_go()
endif
dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), "I")
setcolor('W/BR')
expbox(nMidrow - 12, 6, nMidrow + 11, 73, 1, 30)
setcolor('+W/BR')
rollup("Grumpfish Library is written 99.99% in Clipper.  You get two")
rollup("libraries, one for CA-Clipper 5.01 and another fully optimized")
rollup("for CA-Clipper 5.2, and over 800K of clear Clipper source code!")
rollup("You also get a royalty-free integration license, 275+ pages of")
rollup("printed documentation, a thorough Norton Guide on-line help")
rollup("file, two years free BBS support, and thirty days free voice")
rollup("support.  Plus, our '                   ' guarantee: if you are")
rollup("not absolutely tickled pink by Grumpfish, return it within 30")
rollup("days from your date of purchase for a full and courteous refund!")
rollup('')
rollup('Grumpfish Library 4.0 sells for just $249 (shipping: $7.50 US/')
rollup("Canada, $20 overseas).  Order NOW by calling (800) 367-7613")
rollup("or (503) 588-1815, or fax your order to (503) 588-1980.  ")
rollup('')
rollup(SPACE(20) + 'Grumpfish, Incorporated')
rollup(SPACE(20) + '2450 Lancaster Dr. NE #206')
rollup(SPACE(20) + 'Post Office Box 17761')
rollup(SPACE(20) + 'Salem, Oregon 97305 USA')
rollup('')
rollup('')
rollup(space(5) + "Tel +44 81 994 4842" + space(16) + "Tel 089 570 6031")
rollup(space(5) + "Fax +44 81 994 3441" + space(16) + "Fax 089 570 7631")
setcolor('+GR/BR')
@ nMidrow - 5,29 say 'No Grumpy Customers'
@ nMidrow,    53 say "(800) 367-7613"
@ nMidrow+1,  11 say "(503) 588-1815"
@ nMidrow+1,  48 say "(503) 588-1980"
@ nMidrow+8,  16 say "United Kingdom" color 'i'
@ nMidrow+8,  52 say "Germany" color 'i'
#ifdef MOUSE
ShowMouseCursor()
#endif
inkey(20)
#ifdef MOUSE
HideMouseCursor()
#endif
impbox(60)
ferase('help.dbf')
ferase('help.cfg')
ferase('help.dbt')
ferase('help' + indexext())
ferase('demo2.scr')
ferase('demo3.scr')
set color to
cScrnFile := 'fadeback.scr'
if file(cScrnFile)
   fadein(cScrnFile)
else
   blindopen(cDOSscreen)
endif
ferase(cDOSscreen)
ferase('gftemp.dbf')
setblink(.t.)
setpos(maxrow(), 0)
return nil

function gfdrive()
return ""

function lets_go
local lChecked := .f.
local xx
local any_key
local mfile
local aScreens := {}
local sel := 1
local dumbo
local mstate
local aTemp
local mainmenu
local buff
local maincolor := if(iscolor(), 'w/b', 'w/n')
local mvar
local menulist
local getcolor
local mdate
local mnum
local mstring
local mnum2
local cIndexExt := indexext()
local getlist := {}
local v, w, x, y, z, pass1, pass2, oldf2, team, teams, aTags, indexlist
static aDays := { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
static aLookup := { { "ABCD", "A Better Code Dollop" } , ;
                    { "WXYZ", "Where's Xenia's Young Zoo?" } , ;
                    { "GYRH", "Get Yer Red Hots" } , ;
                    { "WITW", "What In The World!?" } , ;
                    { "NOYH", "Newsprint On Your Hands" } , ;
                    { "TMNB", "This Means Nothing, Bucko" } , ;
                    { "YACA", "Yet Another Cryptic Acronym" } , ;
                    { "DNGC", "Definitely No Grumpy Customers!" } , ;
                    { "PTYF", "Please Tell Your Friends" } , ;
                    { "TSFR", "This Space For Rent" } }
local aTestData := { ;
      { "Greg", "Lief", "503-588-1815", '', '503-588-1980', '', "Grumpfish, Inc.", ;
        "2450 Lancaster Dr., NE", "Salem", "OR", "97305", .t.}, ;
      { "Jennifer", "Lief", "503-588-1815", '', '503-588-1980', '', "Grumpfish, Inc.", ;
        "2450 Lancaster Dr., NE", "Salem", "OR", "97305", .t.}, ;
      { "Mary", "Gries", "503-588-1815", '', '503-588-1980', '', "Grumpfish, Inc.", ;
        "2450 Lancaster Dr., NE", "Salem", "OR", "97305", .t.}, ;
      { "Mark", "Worthen", "503-588-1815", '', '503-588-1980', '', "Grumpfish, Inc.", ;
        "2450 Lancaster Dr., NE", "Salem", "OR", "97305", .t.}, ;
      { "Douglas", "Rist", "503-588-1815", '', '503-588-1980', '', "Grumpfish, Inc.", ;
        "2450 Lancaster Dr., NE", "Salem", "OR", "97305", .t.}, ;
      { "Albert", "Albertson", "208-331-1234", '', '', '', "Albertson's", ;
        "123 Main Street", "Boise", "ID", "83811", .t.}, ;
      { "Adam", "Lief", "202-234-7172", '', '', '', "Club Zeophyte", ;
        "4 F Street, NW", "Washington", "DC", "20005", .t.} }

//ÄÄÄÄÄ additional options menu used by Grumpbrow()
local aMoreOpts := { ;
      { "First extra option",   { | b | dummy(1, b) } }, ;
      { "Second extra option",  { | b | dummy(2, b) } }, ;
      { "Third extra option",   { | b | dummy(3, b) } }, ;
      { "Fourth ~extra option", { | b | dummy(4, b) } }, ;
      { "Last extra option",    { | b | dummy(5, b) } }  ;
                   }

dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), maincolor)
set message to maxrow()  // for Grump's Getsys example
set key K_F1 to helpdev
Shadowbox(0,0,4,16,6,,,'w/r')
@ 1,1 say 'Press F1 to' color '+w/r'
@ 2,1 say 'make your own' color '+w/r'
@ 3,1 say 'help screen!' color '+w/r'
if ! file('demo.scr')
   save_drape('demo.scr')
endif
/*
   create phone database if it doesn't already exist - we will
   need this for GrumpBrow(), POPNOTE(), and SETFILT()
*/
if ! file('phone.dbf')
   dbcreate("phone.dbf",    { {"FNAME",   "C", 15, 0} , ;
                              {"LNAME",   "C", 15, 0} , ;
                              {"PHONE_NO","C", 12, 0} , ;
                              {"EXT",     "C",  4, 0} , ;
                              {"FAX",     "C", 12, 0} , ;
                              {"MOBILE",  "C", 12, 0} , ;
                              {"COMPANY", "C", 20, 0} , ;
                              {"ADDRESS", "C", 25, 0} , ;
                              {"CITY",    "C", 15, 0} , ;
                              {"STATE",   "C",  2, 0} , ;
                              {"ZIP",     "C", 10, 0} , ;
                              {"LONGDIST","L",  1, 0} } )
   use phone
   //----- add dummy records
   for x := 1 to 6
      append blank
      for y := 1 to 12
         fieldput(y, aTestData[x][y])
      next
   next
   use
endif
if ! file('phone' + cIndexExt) .or. ! file('company' + cIndexExt )
   use phone new
   initialize indexes
   index on upper(phone->lname + phone->fname) to phone alias phone
   index on upper(company) to company alias phone
   process indexes
   dbclosearea()
endif
colorset(PRIMARY_COLOR)
shadowbox(nMidrow - 9, 24, nMidrow + 9, 55, 2, "Grumpfish Library 4.0 Demo")
shadowbox(maxrow()-2, 25, maxrow(), 53, 2)
do while sel <> 0 .and. sel <> 17
   /*
      these @..PROMPTS and MENU TO are preprocessed into calls to the
      Grumpfish LITE_MENU2() function, which permits highlighted and/or
      alternate trigger letters, and different colors for each message!
   */
   if empty(menulist)
      @nMidrow - 8,32 prompt "Calculator      "  message "  Useful pop-up calculator "
      @nMidrow - 7,32 prompt "Spreadsheet     "  message "Automatic recalculation etc" ;
                                        triggercolor "N/BG" messagecolor "+W/RB"
      @nMidrow - 6,32 prompt "Notepad         "  message "  Notepad with mail merge  "
      @nMidrow - 5,32 prompt "Phone Directory "  message "Wonderful magnetic rolodex "
      @nMidrow - 4,32 prompt "Calendar/~Appts  " message "Calendar/appointments etc. "
      @nMidrow - 3,32 prompt "Stop~Watch       " message "Pop-up background stopwatch"
      @nMidrow - 2,32 prompt "Filter Builder  "  message "   User-definable filters  "
      @nMidrow - 1,32 prompt "Grump~Brow()     " message "Awesome database browser!!!" ;
                                        triggercolor "N/BG" messagecolor "+W/RB"
      //ÄÄÄÄÄ note use of the WHEN clause on next menu option
      @nMidrow    ,32 prompt "View PHONE.PRG  "  message "Code generated by GrumpBrow" ;
                                        when file('phone.prg')
      @nMidrow + 1,32 prompt "Grump's GETSYS  "  message "Explore new Grumpfish GETs "
      @nMidrow + 2,32 prompt "Bo~x Tricks      " message "Exploding/imploding/etc...."
      @nMidrow + 3,32 prompt "St~ring Tricks   " message "Falling/spreading/teletypes"
      @nMidrow + 4,32 prompt "Screen Tric~ks   " message "Peeling/folding/splitting.."
      @nMidrow + 5,32 prompt "User Feedback   "  message "Many other useful functions"
      @nMidrow + 6,32 prompt "Color ~Management" message "Hooray for static arrays!!!"
      @nMidrow + 7,32 prompt { || "Dynamic options" + if(lChecked, chr(251), chr(32)) } ;
                                                 message "This is a dynamic option..."
      @nMidrow + 8,32 prompt "Exit            "  message "Leaving so soon?  Boo hoo!!"
   endif
   menu to sel initial sel event gfclock(,,'w/b') timeout 30 ;
               noclear_messages messagerow maxrow() - 1      ;
               color 'w/rb,+w/b,n/rb'                        ;
               triggercolor '+w/r'                           ;
               save      // do not clear menulist array each time!
   mainmenu := savescreen(0, 0, maxrow(), maxcol())
   do case

   case sel == 1
      popcalc()

   case sel == 2
      dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), maincolor)
      colorset(C_MESSAGE)
      expbox(0, 1, 8, maxcol() - 2, 1, 10, , "GrumpCalc()")
      @ 1, 3 say 'GrumpCalc() is a full-featured miniature spreadsheet that you can pop up'
      @ 2, 3 say 'within a numeric GET.  Press F2 from within the GET below to pop up the'
      @ 3, 3 say 'spreadsheet.  Within the spreadsheet, do some calculations to derive a'
      @ 4, 3 say 'value.  Then press ESC to return to the GET.  Your final value will be'
      @ 5, 3 say 'pasted into the GET!'
      @ 7, 3 say 'If you need help on active keys in the spreadsheet, press F1.'
      w := 0
      #ifdef MOUSE
      oldf2 := setkey(K_F2, { |p,l,v| HideMouseCursor() , ;
                                      grumpcalc(p, l, v), ;
                                      ShowMouseCursor() } )
      #else
      oldf2 := setkey(K_F2, { |p,l,v| grumpcalc(p, l, v) } )
      #endif
      colorset(maincolor)
      @ 11, 10 say "This is a numeric GET - press F2" get w
      setcursor(1)
      read
      setcursor(0)
      setkey(K_F2, oldf2)
      impbox(50)

   case sel == 3
      use phone new
      popnote()
      use

   case sel == 4
      dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), maincolor)
      popphone()

   case sel == 5
      dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), "I")
      popdate()

   case sel == 6
      popstop()

   case sel == 7 .or. sel == 8
      use phone new
      setcolor(maincolor)
      if sel == 7
         dbsetindex('phone')
         setfilt({ "First name",    ;
                   "Last name",     ;
                   "Phone number",  ;
                   "Extension",     ;
                   "Fax number",    ;
                   "Mobile number", ;
                   "Company",       ;
                   "Address",       ;
                   "City",          ;
                   "State",         ;
                   "Zip Code",      ;
                   "Long Distance" } )
      else
         dbsetindex('phone')
         dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), maincolor)
         colorset(C_MESSAGE)
         exbox(0, 1, 10, maxcol() - 2, 6, 5, '', .t.)
         @ 0, 2 say 'GrumpBrow() is the last word in database browsers.  First off, GrumpBrow()'
         @ 1, 2 say 'includes automatic add/edit/view/delete/QBE/search/output routines.  You '
         @ 2, 2 say 'determine what features are active simply by passing the first letter of '
         @ 3, 2 say 'each option. You can also view data subsets with ALT-S, switch indeces,'
         @ 4, 2 say 'lock columns with L, remap the default keys, pass an extra options menu'
         @ 5, 2 say '(press F10 to see it, and check the demo source code for more information).'
         @ 6, 2 say 'GrumpBrow() also includes a screen painter/code generator.  Press "P" to '
         @ 7, 2 say 'design your data entry screen.  You can move and delete fields, add static '
         @ 8, 2 say 'text, draw boxes, change colors.  (For a complete list of commands, press'
         @ 9, 2 say 'F1 while in the screen painter.)  When finished, press Shift-F10 to generate'
         @10, 2 say 'fully-optimized 5.x code that you can drop in your application immediately!'
         ginkey(1)
         grumpbrow security 'oiflaedvqsp'      ; // add, edit, delete, etcetera
             top 11                            ; // use 11 as top row
             lock 2                            ; // lock leftmost 2 columns
             vblock { |b| showrecno(b) }       ; // hook into vertical movement
             autorefresh 30                    ; // auto-refresh each 30 seconds
             extra aMoreOpts                   ; // additional options menu
             extrakey K_F10                    ; // to pop up add'l opts menu
             colorspec "w/r,+w/b,+w/rb,n/bg"   ; // sets TBrowse colors
             colorblocks {,                    ; // TBrowse override colors
                          { | x | if(x = "Lief", {3,1}, {1,2} ) } ;
                          ,,,,,                ; // for Lastname & Company only
                          { | x | if(x = "Grumpfish", {4,1}, {1,2} ) } ;
                         }                     ;
             index_description { "Last name index", ; // layman's index
                                 "Company index" }  ; //   descriptions
             gotop                             ; // flag to jump to top-of-file
                                                 // when switching indeces

      endif
      close data

   case sel == 9
      if file( mfile := "phone.prg" )
         Shadowbox(0, 0, maxrow(), maxcol(), 2, ;
                   'Viewing GrumpBrow() code', , 'w/rb')
         setcolor('+w/rb')
         memoedit(memoread(mfile), 1, 1, maxrow() - 1, maxcol() - 1, .f.)
      else
         err_msg( { mfile + ;
                   ' not found -- visit the GrumpBrow() screen painter' } )
      endif

   case sel == 10
      dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), 'n/bg')
      colorset(C_MESSAGE)
      expbox(0, 2, 10, 76, 1, 30, setcolor(), "Grumpfish GETSYS")
      @ 1, 7 say "Here is the source code for the GETs at the bottom of the screen"
      aeval(verbiage_, { | text | setpos(row()+1, 3), dispout(text) } )
      ptr := 1         // pointer for highlighted verbiage lines
      w := y := 0
      v := 0.00
      x := space(10)
      z := space(20)
      team := space(9)
      teams := "Orioles;Red Sox;Blue Jays;Indians;Tigers;Yankees"
      pass1 := pass2 := space(12)
      hilite_info(.t.,,getlist)
      @ 14, 0 gget v math when hilite_info(,,getlist) message "Enter a math formula"
      @ 15, 0 gget y calculator cursor when hilite_info(,,getlist) picture '#####.##' ;
              message "Right-to-left entry"
      @ 16, 0 gget team list teams when hilite_info(,,getlist) ;
              message "Use spacebar or backspace to toggle team"
      @ 17, 0 gget w step color 'n/bg,+w/r' when hilite_info(,,getlist) ;
              message "Use + and - keys"
      @ 18, 0 gget pass1 message "Enter a password" password "?" ;
              when hilite_info(,,getlist)
      @ 19, 0 gget pass2 message "Enter a password" password ;
              when hilite_info(,,getlist)
      @ 20, 0 gget z proper message "This will be proper-case" ;
              when hilite_info(,,getlist) valid hilite_info( , .t., getlist)
      @ 21, 0 gget x array aDays picture '@!' noedit message "Please pick a day!"
      setcursor(1)
      read timeout 20 warning 10 exitevent blankscr4(-1)
      setcursor(0)
      waiton("Your passwords were '" + trim(pass1) + "' and '" + ;
              trim(pass2) + "'")
      ginkey(2)
      waitoff()
      impbox(50)

   case sel == 11
      any_key := 'Exploding Box'
      setcolor(maincolor)
      scroll()
      Expbox(00, 00, nMidrow - 3, 36, 5, 20, '+w/rb', any_key)
      ginkey(1)
      Expbox(nMidrow + 2, 10, maxrow() - 1, 50, 1, 24, '+w/r', any_key+' 2')
      ginkey(1)
      Expbox(nMidrow - 5, 01, nMidrow + 4, 60, 2, 50, '+gr/n', any_key+' 3')
      ginkey(.4)
      Expbox(nMidrow, 48, nMidrow + 10, 78, 3, 30, 'n/gr', any_key + ' 4')
      ginkey(.4)
      Expbox(01, 30, 04, 78, 1, 75, '+w/g', 'Yet Another '+any_key)
      inkey(2.5)
      impbox(60)
      ginkey(.3)
      impbox(60)
      ginkey(.3)
      impbox(60)
      ginkey(.3)
      impbox(60)
      ginkey(.3)
      impbox(60)
      ginkey(1)
      *** note the use of the return value and BYEBYEBOX()
      setcolor('n/bg')
      aadd(aScreens, Popbox(00, 00, maxrow() - 2, 40, 2, 18, .F., 'Pop-up Box 1'))
      ginkey(.35)
      setcolor('+gr/n')
      aadd(aScreens, Dropbox(00, 55, maxrow() - 6, 79, 1, 25, .F., 'Pull-down Box 1', .T.))
      ginkey(.35)
      setcolor('n/gr')
      aadd(aScreens, Popbox(03, 44, maxrow() - 4, 70, 5, 20, .F., 'Pop-up Box 2'))
      ginkey(.35)
      setcolor('n/w')
      aadd(aScreens, Dropbox(04, 38, nMidrow + 1, 60, 4, 25, .F., 'Pull-down Box 2'))
      ginkey(.35)
      setcolor('+w/r')
      aadd(aScreens, Popbox(nMidrow, 30, nMidrow + 11, 55, 2, 20, .F., 'Pop-up Box 3', .T.))
      ginkey(.35)
      setcolor('+w/b')
      aadd(aScreens, Popbox(03, 05, nMidrow + 8, 29, 2, 18, .F., 'Another Pop-up'))
      ginkey(.35)
      setcolor('n/g')
      aadd(aScreens, Dropbox(06, 28, nMidrow + 7, 66, 1, 12, .T., 'Another Pull-down Box'))
      ginkey(.35)
      setcolor('n/r')
      aadd(aScreens, Popbox(02, 15, nMidrow + 5, 45, 1, 10, .T., 'Pop-up Box w/ Crossbar', .T.))
      ginkey(.35)
      aadd(aScreens, Shadowbox(nMidrow - 3, 20, nMidrow + 2, 50, 2, 'Shadow Box', .T., ;
                              '+w/rb', 'Press a key to make them vanish!'))
      ginkey(10)
      for xx := 9 to 1 step -1
         ByeByeBox(aScreens[xx])
         ginkey(.12)
      next
      asize(aScreens, 0)

   case sel == 12
      setcolor(maincolor)
      scroll()
      setcolor('+w/bg')
      Exbox(nMidrow - 3, 07, nMidrow + 3, 71, 1, 5, '', .T., 'Silly Strings')
      Spread('It is a snap to display character strings from the middle out',nMidrow-2,35)
      Spread('as we are demonstrating here. You may also wish to use either',nMidrow-1,35)
      Spread('of the two teletype functions, which continuously scroll your',nMidrow,35)
      Spread('message across a specified row.   Perhaps you already saw the',nMidrow+1,35)
      Spread('falling string trick, but in case you missed it,             ',nMidrow+2,35)
      ginkey(4)
      #ifdef MOUSE
      ShowMouseCursor()
      #endif
      FallGuy(nMidrow+2,58,'here it is!!')
      #ifdef MOUSE
      HideMouseCursor()
      #endif
      setcolor(maincolor)
      ginkey(1)
      tty(nMidrow + 8, 'Copyright (C) 1988-93 Greg Lief', 35, 24)
      #ifdef MOUSE
      tty2(maxrow(), 'Press a key or click mouse to return to menu', 0, maincolor)
      #else
      tty2(maxrow(), 'Press any key to return to menu', 0, maincolor)
      #endif

   case sel == 13
      setcolor('W/N')
      for xx := 1 TO 9
         clrscr(xx)
         ginkey(.2)
         if xx < 9
            restscreen(0, 0, maxrow(), maxcol(), mainmenu)
         endif
         ginkey(.2)
      next
      ginkey(1.5)
      mfile := 'DEMO3.SCR'
      pull_drape('demo.scr')
      ginkey(2)
      scroll()
      ginkey(1)
      blindopen('demo.scr')
      hblindsave(mfile)
      ginkey(1)
      blindclose()
      ginkey(2)
      hblindopen(mfile)
      ginkey(2)
      hblindclos()
      ginkey(2)
      if file("fadein.scr")
         fadein("fadein.scr")
         ginkey(2)
      endif
      if file("fadeout.scr")
         fadeout("fadeout.scr")
         ginkey(2)
      endif
      for xx := 0 TO maxrow()
         @ xx, 0 say replicate(chr(xx), maxcol() + 1)
      next
      dumbo := savescreen(0, 0, maxrow(), maxcol())
      hscrnscrl('demo.scr')
      ginkey(.75)
      restscreen(0, 0, maxrow(), maxcol(), dumbo)
      ginkey(.5)
      hscrnscrl('demo.scr', 1)
      ginkey(.75)
      restscreen(0, 0, maxrow(), maxcol(), dumbo)
      ginkey(.5)
      vscrnscrl(mfile)
      ginkey(.75)
      restscreen(0, 0, maxrow(), maxcol(), dumbo)
      ginkey(.5)
      vscrnscrl(mfile, 1)
      ginkey(.75)

   case sel == 14
      dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), maincolor)
      setcolor('+w/bg')
      Expbox(nMidrow - 3, 10, nMidrow + 3, 68, 1, 60, , 'User Feedback')
      Spread('The Grumpfish Library includes many user feedback items.',nMidrow - 2,20)
      Spread('There are functions for yes/no prompts, printer status, ',nMidrow - 1,20)
      Spread('error messages, wait messages, index status graph, state',nMidrow,20)
      Spread("validation, and a sleek ACHOICE() replacement.  We will ",nMidrow+1,20)
      Spread("start out with the index graph function, IndexBar().... ",nMidrow+2,20)
      ginkey(5)
      ImpBox(60)
      if ! file('gftemp.dbf') .or. ! file('lookup.dbf')
         waiton("Preparing temporary files... please wait")
         dbcreate("lookup", { { 'code', 'C', 4, 0 } , ;
                              { 'descrip', 'C', 30, 0} } )
         use lookup new
         for xx := 1 to 10
            append blank
            lookup->code    := aLookup[xx, 1]
            lookup->descrip := aLookup[xx, 2]
         next
         dbcreate("gftemp", { { 'lastname', 'C', 2, 0 }, ;
                              { 'dummy',    'C', 2, 0 }, ;
                              { 'dummy2',   'C', 2, 0 }  } )
         use gftemp new
         for xx := 1 to 1000
            append blank
            gftemp->lastname := chr(gfrand(100) + 65)
            gftemp->dummy    := chr(gfrand(100) + 65)
            gftemp->dummy2   := chr(gfrand(100) + 65)
         next
         waitoff()
      else
         use lookup new
         use gftemp new
      endif
      indexbar('lastname')
      ginkey(2)

      dumbo := Exbox(nMidrow-2, 14, nMidrow+3, 65, 1, 5, '', .T., 'INDEXBAR2()')
      Spread('Next we will look at INDEXBAR2(), which is similar',nMidrow-1,15)
      Spread('to INDEXBAR() but shows cumulative status for more',nMidrow  ,15)
      Spread('than one indexing process. Both the INDEXBAR() and',nMidrow+1,15)
      Spread('INDEXBAR2() functions feature full RDD support!   ',nMidrow+2,15)
      ginkey(4)
      byebyebox(dumbo)

      initialize indexes
      index on lastname to lastname alias gftemp
      index on dummy    to test2 alias gftemp
      index on dummy2   to test3 alias gftemp
      process indexes

      dumbo := Exbox(nMidrow-2, 20, nMidrow+2, 58, 1, 5, '', .T., 'APICK()')
      Spread('This is an example of APICK(): the',nMidrow-1,20)
      Spread('Grumpfish ACHOICE() replacement...',nMidrow,  20)
      Spread('Press spacebar to tag/untag files.',nMidrow+1,20)
      ginkey(4)
      byebyebox(dumbo)
      aTemp := directory("*.*")
      aTags := array(len(aTemp))

      //ÄÄÄÄÄ the following line of code demonstrates how you can pre-tag
      //ÄÄÄÄÄ files for use with APICK().  All .PRG files will be pre-tagged.
      aeval(aTemp, ;
            { | a, x | aTemp[x] := a[1], aTags[x] := "PRG" $ a[1] } )

      apick array aTemp tagging aTags
      gfsaveenv(.t., , '+w/b')
      scroll()
      ? "The following files were tagged:"
      ?
      for xx := 1 to len(aTags)
         if aTags[xx]
            ? aTemp[xx]
         endif
      next
      ?
      ? "Press any key to get on with it...."
      ginkey(0)
      gfrestenv()

      #include "abrowse.ch"

      dumbo := Exbox(nMidrow-2, 20, nMidrow+2, 58, 1, 5, '', .T., 'ABROWSE()')
      Spread('Next we will look at ABROWSE(), the',nMidrow-1,20)
      Spread('powerful and flexible nested array ',nMidrow,  20)
      Spread('browser/editor for CA-Clipper 5.x..',nMidrow+1,20)
      ginkey(4)
      byebyebox(dumbo)

      aTemp := { ;
                   { ;
                     1, 2, { ;
                             { "gregory ", 194 }, ;
                             { "jennifer", 208 }, ;
                             { "justin",   992 }  ;
                            } ;
                   }, ;
                   { 4, 5, 6 }, ;
                   { 7, 8, 9 }, ;
                   {10,11,12 }, ;
                   {13,14,15 }, ;
                   {16,17,18 }, ;
                   {19,20,21 }  ;
                 }
      abrowse(,,,,aTemp,,, {,,10}, 'Sample Title', .t., .t.)
      ginkey(1)

      //ÄÄÄÄÄ then again for DIRECTORY() array,
      //ÄÄÄÄÄ using ABROWSE user-defined command
      abrowse array directory() ;
              headings { "File Name", "File Size", "File Date", "File Time", "Attr" } ;
              widths {12} celledit

      if ! yes_no('This is one of the two Grumpfish yes/no prompts',;
                  'Want to see the other one')
         Err_Msg( { "Too bad, you're going to see it anyway" } )
      ENDif

      yes_no2({'Shall we zap the database now?'}, nMidrow, ' OK ', ' Cancel ', .F.)

      if ! yes_no2({'Send the report to:'}, nMidrow, ' Printer ', ' File ')
         waiton("Let's assume that we are printing now")
         ginkey(2)
         waitoff()
      endif
      ginkey(1)

      if isprinter()
         waiton('Please turn off your printer for this demo')
         do while isprinter()
         enddo
         waitoff()
      endif
      printok()
      set device to screen
      Err_msg( { 'This is the error message function!' } )

      setcolor('+w/rb')
      dumbo := Exbox(nMidrow-2, 20, nMidrow+2, 59, 1, 5, '', .T., 'GETDATE()')
      Spread("Get dates the easy way with Grump's", nMidrow-1, 22)
      Spread('GetDate() function, which includes ', nMidrow,   22)
      Spread('integrated holiday support (in red)', nMidrow+1, 22)
      ginkey(2)
      //ÄÄÄÄÄ 2nd and 3rd parameters to GetDate() position the box on-screen
      if ! empty( x := GetDate(date(), 0, 56) )
         Spread('You selected ' + dtoc(x), 14, 20)
      endif
      ginkey(3)
      byebyebox(dumbo)

      lookup->( dbCloseArea() )
      gftemp->( dbCloseArea() )

      setcolor('+w/r')
      dumbo := Exbox(nMidrow-1, 20, nMidrow+2, 59, 1, 5, '', .T., 'GFPICKFILE()')
      Spread("Pick files easily with GFPickFile()", nMidrow, 22)
      Spread("(Press F10 to view file structure) ", nMidrow+1, 22)
      ginkey(2)
      if ! empty( x := gfpickfile( , K_F10) )
         Spread('You selected ' + StripPath(x), nMidrow+2, 20)
      endif
      ginkey(3)
      byebyebox(dumbo)

      dumbo := Exbox(nMidrow-2, 15, nMidrow+2, 64, 1, 5, '', .T., 'Validation')
      Spread('Grumpfish Library offers validation routines for',nMidrow-1,21)
      Spread('state abbreviations and Canadian postal codes...',nMidrow,21)
      mstate := space(2)
      @ nMidrow+1, 21 say "Enter a state abbreviation now:" ;
                      get mstate valid isstate()
      setcursor(1)
      read
      setcursor(0)
      ginkey(2)
      byebyebox(dumbo)

      use lookup new
      setcolor('+W/R')
      dumbo := Exbox(nMidrow-2, 13, nMidrow+3, 66, 1, 5, '', .T., 'HELPBROW()')
      Spread("Last but not least, Grumpfish has a great picklist", nMidrow-1, 20)
      Spread("function for data validation.  HELPBROW() makes it", nMidrow, 20)
      Spread("easy to let users add new items to lookup tables..", nMidrow+1, 20)
      ginkey(1)
      mvar := "JUNK"
      @ nMidrow+2, 15 say "Your code:" get mvar valid helpbrow("lookup", "code", ;
                   "Code", "descrip", "Description", .t., "+w/b", nMidrow+2, 35, ;
                   ,,,,,,.f.)
      setcursor(1)
      read
      setcursor(0)
      ginkey(1)
      byebyebox(dumbo)
      close data
      ferase('lastname' + cIndexExt)
      ferase('test2' + cIndexExt)
      ferase('test3' + cIndexExt)

   case sel == 15
      dispbox(0, 0, maxrow(), maxcol(),  replicate(chr(250),9), 'w/b')
      colormod()

   case sel == 16
      waiton( { "With the Grumpfish menu replacement, you can use code blocks", ;
                "instead of literal strings.  If a code block is detected, it", ;
                "will be evaluated to determine what to display as the prompt" })
      lChecked := ! lChecked
      ginkey(8)
      waitoff()

   endcase
   restscreen(0, 0, maxrow(), maxcol(), mainmenu)
   colorset(PRIMARY_COLOR)
enddo
ferase('lookup.dbf')
return NIL


static function showrecno(browse)
@ maxrow(), 0 say "You can hook into the Grumpbrow() movement like this!  " + ;
                  "Current record # " + ltrim(str(recno())) color "+gr*/b"
return nil


static function dummy(n, browse)
//ÄÄÄÄÄ NOTE: message centered in the browse window
waiton( { "Additional option #" + ltrim(str(n)) },,, ;
          browse:nTop + ((browse:nBottom - browse:nTop) / 2) - 1)
inkey(1)
waitoff()
return nil


static function rollup(mtext)
local xx
scroll(nMidrow - 11, 8, nMidrow + 10, 71, 1)
@ nMidrow + 10, 8 say padr(mtext, 64)
for xx := 1 to 35
next
return nil



static function hilite_info(restart, lastline, getlist)
static buffer
//ÄÄÄÄÄ if 1st parameter was passed, clear out old BUFFER and do nothing else
if restart <> NIL
   buffer := NIL
else

   dispbegin()

   setpos(ptr + 1, 3)
   //ÄÄÄÄÄ restore previous line if there was one saved
   if buffer <> NIL
      restscreen(row(), col(), row(), maxcol(), buffer)
   endif

   //ÄÄÄÄÄ 2nd parameter passed only to force highlighting of last line
   //ÄÄÄÄÄ necessary cause you can't use ARRAY clause in conjunction with a WHEN
   if lastline <> NIL
      ptr := len(verbiage_)
   else
      ptr := ggetno(,getlist)
   endif

   //ÄÄÄÄÄ move to new position, save screen, and display text
   setpos(ptr + 1, 3)
   buffer := savescreen(row(), col(), row(), maxcol())
   dispout(padr(verbiage_[ptr], 73), colorset(C_MESSAGEBLINK, .T.))

   dispend()

endif
return .t.

* end of file DEMO5.PRG
