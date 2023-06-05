/**
To build
--------

hbmk2 main.prg 

*/
// The example demonstrates how HB_LangMessage() can be used, and compares
// it to other functions embedded into the national language support. The
// example uses the English and Spanish languages.

#include "hblang.ch"

REQUEST HB_LANG_ES   // request the Spanish language module

/*
Thanks A Santos : https://groups.google.com/g/harbour-users/c/T1KOYsK18ho




(from xHarbour Language Reference Guide (Version 1.1) )

HB_LangMessage()
Returns language specific messages or text strings.

Syntax
HB_LangMessage( <nMessageID> ) --> cMessage 

Arguments 
<nMessageID> This is a numeric code identifying the message to retrieve. 
The message ID is composed of a base number plus an offset. 
#define constants are available in the file Hblang.ch that can be used as base number for various language specific messages:

Bases for language specific messages

Constant                             Value Max.                 offset     Description 
HB_LANG_ITEM_BASE_ID                         0                       6     Identification messages 
HB_LANG_ITEM_BASE_MONTH                      6                      12     Month names 
HB_LANG_ITEM_BASE_DAY                       18                       7     Day names 
HB_LANG_ITEM_BASE_NATMSG                    25                      13     Clipper compatible NationMsg() messages 
HB_LANG_ITEM_BASE_ERRDESC                   38                      52     PRG error descriptions 
HB_LANG_ITEM_BASE_ERRINTR                   90                      26     xHarbour internal error descriptions 
HB_LANG_ITEM_BASE_TEXT                     116                       3     Miscellaneous text strings
Return
The function returns a character string identified by its numeric identifier according to the currently selected national language.

Description
HB_LangMessage() is part of xHarbour's language specific system. 
The returned character string depemds on the currently selected national language (see HB_LangSelect())
 and the passed numeric message ID. The message ID is composed of a base value and an offset.

Note:  a programmer is rarely required to use HB_LangMessage() directly, 
since other functions exist that take the offset for the message ID into account. 

For example, the functions CMonth() or CDoW() are functions that retrieve character strings holding the name of a month or day. 
Also HB_LangErrMsg() accepts the #define constants found in Error.ch as message identifier and returns an appropriate error message.

HB_LangMessage() is the most generic function of xHarbour's national language 
support system and returns a built-in character string identified by a 
numeric identifier for the currently selected national language.

Info
See also: HB_LangName(), HB_LangErrMsg(), HB_LangSelect(), NationMsg() 

Category: Language specific , xHarbour extensions 

Header: HbLang.ch 

Source: rtl\langapi.c, lang\msg*.c 

LIB: xhb.lib DLL: xhbdll.dll
*/
PROCEDURE Main
   LOCAL dDate := StoD( "20070212" )

   ? HB_LangMessage( HB_LANG_ITEM_BASE_DAY + 1 )
                                    // result: Monday
   ? CDoW( dDate )                  // result: Monday

   ? HB_LangMessage( HB_LANG_ITEM_BASE_MONTH + 2 )
                                    // result: February
   ? CMonth( dDate )                // result: February

   ? HB_LangMessage( HB_LANG_ITEM_BASE_ERRDESC + 1 )
                                    // result: Argument error
   ? HB_LangErrMsg( 1 )             // result: Argument error

   ** select Spanisch as national labguage
   HB_LangSelect( "ES" )

   ? HB_LangMessage( HB_LANG_ITEM_BASE_DAY + 1 )
                                    // result: Lunes
   ? CDoW( dDate )                  // result: Lunes

   ? HB_LangMessage( HB_LANG_ITEM_BASE_MONTH + 1 )
                                    // result: Febrero
   ? CMonth( dDate )                // result: Febrero

   ? HB_LangMessage( HB_LANG_ITEM_BASE_ERRDESC + 1 )
                                    // result: Error de argumento
   ? HB_LangErrMsg( 1 )             // result: Error de argumento

RETURN




