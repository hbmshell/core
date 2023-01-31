/**



*/

PROCEDURE MAIN

    LOCAL cCodePage

    FOR EACH cCodePage IN hb_cdpList()
        ?  cCodePage
    NEXT

RETURN
