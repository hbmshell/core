//https://www.kresin.ru/en/hrbfaq_4.html

PROCEDURE MAIN

    ? "Test zip."
    ? hb_ZipTestPK( "bit.zip" )

RETURN
/*
0     Ok
114   Incorrect Disk
103   No Call back was set with hb_ZipTestPK()
*/
