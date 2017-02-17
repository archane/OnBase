-- This is one I think EVERY OnBase Admin should have. We all need to know which Doctype are not being used and which ones are.

SELECT ct.itemtypename as "Doc Type",rs.itemname as "Document Name",rs.itemtypenum as "Doc Type ID",rs.logdate as "Date Viewed",rs.username as "User",ct.counts as "Total Documents"
    FROM (
        SELECT id.itemtypenum, tx.logdate, us.username,id.itemname, Rank() 
          over (Partition BY id.itemtypenum
                ORDER BY  tx.logdate DESC ) AS Rank
        FROM hsi.transactionxlog tx,hsi.itemdata id ,hsi.useraccount us
		where id.itemnum=tx.num 
		and tx.usernum = us.usernum
		and tx.actionnum=4 and tx.subactionnum=1
        ) rs, 
		(select count(*) as counts,dt.itemtypename,id.itemtypenum 
		from hsi.itemdata id,hsi.doctype dt
		where id.itemtypenum= dt.itemtypenum
		and dt.itemtypename not like '%SYS%'
		--and dt.itemtypenum in ('') --if you need to specify doc types --uncomment this and add the doctypenum if you need just a single doctype or list of doctypes
		 group by id.itemtypenum ,dt.itemtypename
		 ) ct
		WHERE Rank <= 10 and rs.itemtypenum = ct.itemtypenum
