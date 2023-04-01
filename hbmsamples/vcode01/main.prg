
PROCEDURE MAIN
   
    LOCAL oObj

    // 
    AltD()
    oObj := VCodePrg():New( "codetest.prg" )
    oObj:SetIniBlock( "@" )
    oObj:SetEndBlock( "@@" )
    oObj:SetAutomatic( "Auto" )

    oObj:IniBlock('main')
    oObj:WriteLn("PROCEDURE Main")
    oObj:WriteLN("    ? 'Hello World'")
    oObj:WriteLN("    RETURN")
    oObj:EndBlock()

    oObj:IniBlock('func')
    oObj:WriteLN("FUNCTION Sum")
    oObj:WriteLN("RETURN")

    oObj:EndBlock()

RETURN