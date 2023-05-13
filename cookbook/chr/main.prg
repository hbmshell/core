/**
Description
-----------
See chr ascii codes

To build
--------

hbmk2 main.prg 

*/
function main()
    local i
     
     
    for i = 160 to 180
        ? i, "=" , chr(i)
    next
return
