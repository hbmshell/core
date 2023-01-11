#require "rddsql"


PROCEDURE HBM_34tbrowse

    LOCAL oTB, uDummy
    LOCAL aStruct := { { "NAME", "C", 20, 0 }, { "FAMILYNAME", "C", 20, 0 }, { "BIRTH", "D", 8, 0 }, { "AMOUNT", "N", 9, 2 } }

    rddSetDefault( "SQLMIX" )
    dbCreate( "customer", aStruct , , .T., "customer" )
 
    dbAppend(); AEval( { PadR( "Bil", 20 ),  PadR( "Gatwick", 20 ),  hb_SToD( "19650124" ), 123456.78 }, {| X, Y | FieldPut( Y, X ) } )
    dbAppend(); AEval( { PadR( "Tom", 20 ),  PadR( "Heathrow", 20 ), hb_SToD( "19870512" ),   9086.54 }, {| X, Y | FieldPut( Y, X ) } )
    dbAppend(); AEval( { PadR( "John", 20 ), PadR( "Weber", 20 ),    hb_SToD( "19750306" ),   2975.45 }, {| X, Y | FieldPut( Y, X ) } )
    dbAppend(); AEval( { PadR( "Sim", 20 ),  PadR( "Simsom", 20 ),   hb_SToD( "19930705" ),  32975.37 }, {| X, Y | FieldPut( Y, X ) } )
    GO TOP

    oTB := TBrowseDB()// 10, 10, 15, 40 )
    oTB:AddColumn(TBColumnNew("Last Name",{||Customer->Name}))
    oTB:AddColumn(TBColumnNew("First Name",{||Customer->familyName}))
    oTB:AddColumn(TBColumnNew("Phone",{||Customer->Birth}))
    uDummy := NIL

    cls
    @ 09,09 to 16,81
    @ 10, 10, 15, 80 GET uDummy TBROWSE oTB
    READ
    
    @ 29,10 SAY hb_strformat( "uDummy variable doesn't change : %s", hb_valtoexp(uDummy) ) COLOR "W/N"
    @ 30,10 SAY hb_strformat( "Name value : %s, Recno: %d", hb_valtoexp(Customer->Name) , RecNo() )  COLOR "W/N"
    CLOSE 
    WAIT 
    
RETURN


