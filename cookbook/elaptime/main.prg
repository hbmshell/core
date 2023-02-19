//http://www.pctoledo.com.br/forum/viewtopic.php?f=1&t=3139
PROCEDURE MAIN

    ? ElapTime( "08:00:00", "10:10:11" )  // 02:10:11"
    ? ElapTime( "14:00:00", "18:00:00" )  // 04:00:00
    ? ElapTime( "22:15:00", "01:00:00" )  // after midnight - 02:45:00
    
RETURN
