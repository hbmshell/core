/*
  Thanks : http://harbourlanguage.blogspot.com/2010/04/harbour-gt.html
  
*/

#include "hbgtinfo.ch"

//REQUEST HB_LANG_PT
//REQUEST HB_CODEPAGE_PT850
//REQUEST HB_GT_WVT_DEFAULT

Function Main()


 hb_gtInfo( HB_GTI_FONTSEL, "courier new") 

 Hb_GtInfo( HB_GTI_FONTWIDTH, 40 ) 

 HB_GTInfo( HB_GTI_FONTSIZE, 50) 

 Name=space(30) 

 @ 2,2 SAY "Name" GET name

 Read 

 @ 3,2 SAY "Hello "+name 

 INKEY( 0 ) 

 return

Return Nil