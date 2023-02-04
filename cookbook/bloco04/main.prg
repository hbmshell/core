

FUNCTION Main
LOCAL b1, b2

   b1 := {||  
            SET DATE BRITISH 
         }
 
   EVAL( b1 ) 
   
   ? DATE()  
   
   BEGIN SEQUENCE WITH __BreakBlock()

       b2 := {|| SET DATE BRITISH } // <-- Error
       
   RECOVER 
         
      ? "An standard codeblock doesn't permit commands and many lines"

   END     
   
          
RETURN NIL

