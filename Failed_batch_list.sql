select itemdatapage.batchnum,parsedqueue.parsefilename,parsedqueue.dateended,count(*) as totalfiles 
from hsi.itemdatapage, hsi.parsedqueue where filetypenum <> 1 
and itemdatapage.batchnum = parsedqueue.batchnum 
and itemdatapage.batchnum in (select batchnum from hsi.parsedqueue where itemdate > getdate()-5 --change this to see a larger date range
and batchnum not in ('12394','12395')) --known bad batches due to date issue (ie. 01/01/2099)
group by itemdatapage.batchnum,parsedqueue.dateended,parsedqueue.parsefilename 
order by itemdatapage.batchnum desc
