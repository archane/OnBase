-- Used to pull the Memo's stored in Work View Solutions based on the attribute ID from the Work View solution.
select * from (
select rmm.memo,rmo.transactionid, rmo.attributeid,substr(rmo.endvalue,8,length(trim(rmo.endvalue))) as memoid1, rmo.transactiondate, rmo.username 
from hsi.RMOBJECTHISTORY rmo,hsi.rmmemo rmm
where attributeid = 1083 --Cost Share ID
and substr(rmo.endvalue,8,length(trim(rmo.endvalue))) = rmm.memoid
order by rmo.transactiondate desc)
where rownum = 1 -- remove to pull a complete list
