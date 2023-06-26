-- Example of how to tie keywords to a specific Doctype

select id.itemnum as "OnBase Doc Handle",k207.keyvaluechar as "Process Type", k210.keyvaluedate as "Recieve Date", Tbl.keyvaluechar as "PA Number" 
from hsi.itemdata id, hsi.keyitem207 k207, hsi.keyitem210 k210, hsi.keyxitem117 XTbl, hsi.keytable117 Tbl
where id.itemtypenum=1917
And XTbl.keywordnum = Tbl.keywordnum 
and id.itemnum = XTbl.itemnum
and id.itemnum = k207.itemnum
and id.itemnum = k210.itemnum
and id.itemdate > sysdate -131
and id.itemdate < sysdate -12
and k207.keyvaluechar = 121
and rownum < 10
