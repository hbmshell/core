// Thanks 
// https://groups.google.com/g/harbour-users/c/WGV6rivYzzg
FUNCTION Main()
   LOCAL cFuncName

   cFuncName := "SOME_FUNC"
   UDF_DEFFUN( cFuncName, @MY_FUNC() )          // add redirection
   ? &cFuncName( 'abc', 123, Date() )           // show my_func() result
   UDF_DEFFUN( cFuncName, {| p | Upper( p ) } ) // change redirection
   ? &cFuncName( 'abc', 123, Date() )           // show "ABC"
   UDF_DEFFUN( cFuncName )                      // remove redirection
   //? &cFuncName( 'abc', 123, Date() )           // gen RTE (Error FUnction SOME_FUNC() doesn't exists)

RETURN NIL

STATIC FUNCTION MY_FUNC( ... )
RETURN hb_ValToExp( { ... } )


/* missing function redirector based on standard error handler */

#include "error.ch"

FUNCTION UDF_DEFFUN( cFuncName, bCode )

   STATIC s_hUdfSubst
   LOCAL bError

   IF HB_ISHASHKEY( cFuncName )
      IF s_hUdfSubst == NIL
         s_hUdfSubst := { => }
         bError := ErrorBlock( {| oError | UDF_ErrorCode( oError, bError, s_hUdfSubst ) } )
      ENDIF
      IF HB_ISEVALITEM( bCode )
         s_hUdfSubst[ cFuncName ] := bCode
      ELSE
         hb_HDel( s_hUdfSubst, cFuncName )
      ENDIF
   ENDIF

RETURN NIL

STATIC FUNCTION UDF_ErrorCode( oError, bError, hUdfSubst )
   LOCAL bFunc

   IF oError:genCode == EG_NOFUNC .AND. oError:subCode == 1001 .AND. ;
      oError:canSubstitute .AND. ;
      ( bFunc := hb_HGetDef( hUdfSubst, oError:operation ) ) != NIL
      RETURN Eval( bFunc, hb_ArrayToParams( oError:args ) )
   ENDIF

RETURN Eval( bError, oError )