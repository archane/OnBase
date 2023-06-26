-- Simple list of OnBase users that are currently active
select count(*) from hsi.useraccount
where disablelogin <> 1
and username not like '%deactivated%'
and username not like '%DELETED%'
and lastlogon >= sysdate-180
order by usernum asc
