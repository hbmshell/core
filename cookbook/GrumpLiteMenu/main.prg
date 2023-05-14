
// hbmk2 main.prg -lgrump 
procedure main

// Clipper 5.0 syntax - note use of the color parameters^R
// please compile and run this to see what happens  

cls
lite_menu(5, 6, { 'Data entry', 'Reports', 'Invoices', ;
          'Reindex ~Files', 'Dumb ~Stuff', 'Quit' } ,  ;
          .f., 'w/b', '+w/r', , 'Sample', 'n/bg')
   
return