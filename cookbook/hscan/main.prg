/**

hbmk2 hscan.prg xhb.hbc

*/
#xtranslate text into <v> [<rst:reset>]   => #pragma __text|<v>+=%s;if(<.rst.>,<v>:="",)

PROCEDURE Main

    local htable := {"message"=>"Evento retornado",;
                     "status_consulta"=>{"mensagem"=>"[b]Lote processado com sucesso[/b]."}}
    ? "Hash content : " , hb_ValToExp( hTable )
    ? "Seek [b]Lote processado com sucesso[/b] in hTable => ", IIF( HScan( hTable , "[b]Lote processado com sucesso[/b]." ) <> 0, "Found","Not found")
    ? e"Seek [b]Lote processado com sucesso[/b] in hTable[\"status_consulta\"] => ", IIF( HScan( hTable[ "status_consulta" ] , "[b]Lote processado com sucesso[/b]." ) <> 0,"Found","Not found") 
    ? "Seek Evento retornado in hTable => " , IIF( HScan( hTable, "Evento retornado" ) <> 0, "Found","Not found")


    RETURN
