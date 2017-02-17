--used to find a column name in all tables, VERY handy for obscure databases where the structure is segmented
select q.table_name, f.RowCounts
from information_schema.COLUMNS q,(SELECT 
    t.NAME AS TableName,
    p.rows AS RowCounts
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255
	and p.rows <> 0 
GROUP BY 
    t.Name, p.Rows) f 
where column_name like 'itemnum' --column name goes here
and f.TableName = q.TABLE_NAME
order by RowCounts asc
