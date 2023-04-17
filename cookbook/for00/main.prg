/**

Thanks!
-------
http://harbourlanguage.blogspot.com/2011/10/understanding-harbour-from-sample.html

To build
--------

hbmk2 main.prg 

*/
PROCEDURE Main
 local d
     set date format to "dd/mm/yyyy"
     for d := d"2011-10-05" to d"2011-10-20"
        ? d
     next
     ?
     d := d"2011-10-05"
     ? d, ++d, ++d
     d+=25
     ? d

RETURN
