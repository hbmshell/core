
PROCEDURE Main

    LOCAL cFullFileName := "/home/test.dbf"
    LOCAL cPathFile, cFileAlias, cExtension
   	
    ? "Original : " , cFullFileName
    HB_FNameSplit( cFullFileName      , ;                                                                                                                                       
                @cPathFile  , ;                                                                                                                                    
                @cFileAlias , ;                                                                                                                                    
                @cExtension  ) 
                
    ? "Path : " ,  cPathFile
    ? "Extension : " , cExtension
    ? "Single name : " , cFileAlias
    ?




RETURN
