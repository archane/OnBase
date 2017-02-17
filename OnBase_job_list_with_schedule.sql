-- Displays every scheduled task in OnBase with Server, Interval,start time, stop time and which days it runs.
select ru.registername,sp.schedprocname,
sp.procinterval, test.schedstarttime, test.schedendtime,
max(test.Sunday)as Sunday,max(test.Monday)as Monday,max(test.Tuesday)as Tuesday,max(test.Wednesday)as Wednesday,max(test.Thursday)as Thursday,max(test.Friday)as Friday,max(test.Saturday)as Saturday from
onbase.hsi.scheduledprocess sp,onbase.hsi.registeredusers ru,
 (
select st.schedtemplatenum,st.schedstarttime, st.schedendtime,
case when sd.value1 = '1' then '1' else '' end as Sunday,
case when sd.value1 = '2' then '1' else '' end as Monday,
case when sd.value1 = '3' then '1' else '' end as Tuesday,
case when sd.value1 = '4' then '1' else '' end as Wednesday,
case when sd.value1 = '5' then '1' else '' end as Thursday,
case when sd.value1 = '6' then '1' else '' end as Friday,
case when sd.value1 = '7' then '1' else '' end as Saturday

from onbase.hsi.scheduletemplate st,onbase.hsi.scheduledday sd
where st.schedtemplatenum= sd.schedtemplatenum) test
where  sp.schedtemplatenum = test.schedtemplatenum
and sp.registernum =ru.registernum
group by ru.registername,sp.schedprocname,
sp.procinterval, test.schedstarttime, test.schedendtime
