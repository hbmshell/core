//https://vivaclipper.wordpress.com/tag/csetref/
FUNCTION hb_Main()

    ? "Replace the trailing spaces with dashes:" , REPLRIGHT("abcd  ", "-")        // "abcd--"
    ? "Replace the trailing dashes with spaces:" , REPLRIGHT("abcd--", " ", "-")   // "abcd  "
    ? "Replace only the trailing spaces: ", REPLRIGHT("   1  ", "-")        // "   1--"
       
RETURN