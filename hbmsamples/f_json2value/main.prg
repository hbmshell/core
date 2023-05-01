
PROCEDURE MAIN
    
    
    ? "-------------------------------------------------------------------------"
    ? "Method 1 : 2th Parameter is a array : ", 'E.g: {"company","cio"}'
    ? "Test 1.1 - Method 1 : Found"
    ? VLJ_ConfigJson2Value( "latex.json" , {"company","cio"}  , "don't find CIO" )
    ? "Test 1.2 - Method 1 : Not Found"
    ? VLJ_ConfigJson2Value( "latex.json" , {"company","unknow"} , "don't find CIO"  )
    ? "-------------------------------------------------------------------------"
    ? "Method 2 : 2th Parameter is a string separated with character '.' : ", 'E.g: "company.cio"'
    ? "Test 2.1 - Method 2 : Found"
    ? VLJ_ConfigJson2Value( "latex.json" , "company.cio"  , "don't find CIO" )
    ? "Test 2.2 - Method 2 : Not Found"
    ? VLJ_ConfigJson2Value( "latex.json" , "company.unknow" , "don't find CIO"  )
    ? "-------------------------------------------------------------------------"
    ? "Method 3 : 2th Parameter is a string separated with character ';' (defined in 4th parameter) : ", 'E.g: "company;cio"'
    ? "Test 3.1 - Method 3 : Found"
    ? VLJ_ConfigJson2Value( "latex.json" , "company;cio"  , "don't find CIO" , ";" )
    ? "Test 3.2 - Method 3 : Not Found"
    ? VLJ_ConfigJson2Value( "latex.json" , "company;unknow" , "don't find CIO" , ";"  )
    
    
RETURN