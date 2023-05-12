

#include "abrowse.ch"

function main
local a := { ;
             { ;
               1, 2, { ;
                       { "gregory ", 32 }, ;
                       { "jennifer", 31 }, ;
                       { "justin",   10 }  ;
                      } ;
             }, ;
             { 4.99, 5, 6 }, ;
             { 7.00, 8, 9 }, ;
             {10.25,11,12 }, ;
             {13.19,14,15 }, ;
             {16.29,17,18 }, ;
             {19.05,20,21 }  ;
           }
abrowse(,,,,a,,, {,,10}, 'the title', .t., .t., { "##.##" } )
inkey(0)

//ÄÄÄÄÄ then again for DIRECTORY() array, using ABROWSE user-defined command
abrowse array directory() headings { "name", "size", "date", "time", "attr" } ;
                          widths {12} celledit
return nil

