select itemdatapage.batchnum,parsedqueue.parsefilename,sum(cast(filesize as bigint)) as size 
from hsi.itemdatapage, hsi.parsedqueue where filetypenum <> 1 
and itemdatapage.batchnum = parsedqueue.batchnum 
and itemdatapage.batchnum in (select batchnum from hsi.parsedqueue where itemdate > getdate()-5 --change this number to increase date range
and batchnum not in ('12394','12395')) --add known batches with date issues here, (ie. 01/01/2099 issue)
group by itemdatapage.batchnum,parsedqueue.parsefilename order by size desc
