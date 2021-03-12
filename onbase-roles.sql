select distinct(wkstmachinename), wkstprocessrole, max(lastheartbeat) from onbase.hsi.wkstmonitor
where wkstprocessrole = 'ApplicationServer'
and lastheartbeat > getdate()-365
group by wkstmachinename, wkstprocessrole
--order by wkstmachinename desc

UNION

select distinct(wkstmachinename), wkstprocessrole, max(lastheartbeat) from onbase.hsi.wkstmonitor
where wkstprocessrole = 'Scheduler'
and lastheartbeat > getdate()-365
group by wkstmachinename, wkstprocessrole
--order by wkstmachinename desc

union

select distinct(wkstmachinename), wkstprocessrole, max(lastheartbeat) from onbase.hsi.wkstmonitor
where wkstprocessrole = 'SchedulerService'
and lastheartbeat > getdate()-365
group by wkstmachinename, wkstprocessrole
--order by wkstmachinename desc

union

select distinct(wkstmachinename), wkstprocessrole ,max(lastheartbeat)  from onbase.hsi.wkstmonitor
where wkstprocessrole = 'WorkflowTimerService'
and lastheartbeat > getdate()-365
group by wkstmachinename, wkstprocessrole
--order by wkstmachinename desc

union

select distinct(wkstmachinename), wkstprocessrole, max(lastheartbeat) from onbase.hsi.wkstmonitor
where wkstprocessrole = 'Scheduled Process'
and lastheartbeat > getdate()-365
group by wkstmachinename, wkstprocessrole
--order by wkstmachinename desc
order by wkstprocessrole desc
