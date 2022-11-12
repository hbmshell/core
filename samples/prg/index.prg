
//-q0
FUNCTION __Index()

    LOCAL hRet := { => }

    hRet[ "User" ] := "Vlad"
    hRet[ "Number" ] := "4"
    hRet[ "Time" ] := TIME()
    GetMime("json")
    ? "OKOKOKOKO"

    RETURN HB_JsonEncode( hRet )
