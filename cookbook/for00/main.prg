/**

Thanks!
-------
http://harbourlanguage.blogspot.com/2011/10/understanding-harbour-from-sample.html

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main
 local dMyDate
     set date format to "dd/mm/yyyy"
     for dMyDate := d"2011-10-05" to d"2011-10-20"
        ? dMyDate
     next
     ?
     dMyDate := d"2011-10-05"
     ? dMyDate, ++dMyDate, ++dMyDate
     dMyDate+=25
     ? dMyDate

RETURN
