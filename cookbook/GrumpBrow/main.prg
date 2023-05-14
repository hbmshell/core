
#include "grumpbro.ch"

PROCEDURE MAIN


     dbCreate( "user.dbf" , { { "LOGIN" , "C" , 30 , 0 } , { "PASS" , "C" , 30 , 0 } } )

    CLS
     USE user    
     GRUMPBROW SECURITY 'AED' 
/**
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

*/



RETURN
