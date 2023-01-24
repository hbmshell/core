/*
Arrays
*/
PROCEDURE Main
          
           
    FirstForm()
    SecondForm()
    
RETURN


PROCEDURE FirstForm
LOCAL aClientes := ARRAY( 2 ) // Spaces reserved in Compiled time (Declare and Initialize)          
           
    // Fill elements  
    aClientes[1] := "Joseph"
    aClientes[2] := "Mary"  

    ? aClientes[1], " and ", aClientes[2]
    
    
RETURN

PROCEDURE SecondForm
LOCAL aClientes := {} // Blank array (Declare only)
                   
    // Initialize (run time) and fill elements 
    AADD( aClientes , "Joseph" )
    AADD( aClientes , "Mary" )
    
    ? aClientes[1], " and ", aClientes[2]
    
RETURN



