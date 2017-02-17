select b.sam_account_name,b.first_name + ' ' + b.last_name as admin_name, b.name_manager, b.department, b.job_description, b.business_unit
 from OnBase.dbo.dsfcu_employee b, OnBase.dbo.dsfcu_jobs j
 where b.job_description = j.Job_title
 and b.department <> 'Administration'

UNION ALL 
select c.sam_account_name,c.first_name + ' ' + c.last_name as admin_name, c.name_manager, d.department, c.job_description, c.business_unit
 from OnBase.dbo.dsfcu_employee c, (select b.name_manager, b.business_unit, b.department,
case when name_manager in (select a.first_name + ' ' + a.last_name as admin
			from OnBase.dbo.dsfcu_employee a
			where a.department = 'Administration'
			and a.first_name + ' ' + a.last_name = b.name_manager) then 'True'
else 'False'
end as admin_status
 from OnBase.dbo.dsfcu_employee b

 ) d
 where c.department = 'Administration'
 and c.job_description not like '%Assistant%'
 and c.first_name + ' ' + c.last_name = d.name_manager
   group by c.sam_account_name,c.first_name, c.last_name, c.name_manager, d.department, c.job_description, c.business_unit

UNION ALL

select e.sam_account_name,e.first_name + ' ' + e.last_name as admin_name, e.name_manager, f.department, e.job_description, e.business_unit
from OnBase.dbo.dsfcu_employee e, (select c.first_name + ' ' + c.last_name as admin_name, c.name_manager, d.department, c.job_description, c.business_unit
 from OnBase.dbo.dsfcu_employee c, (select b.name_manager, b.business_unit, b.department,
case when name_manager in (select a.first_name + ' ' + a.last_name as admin
			from OnBase.dbo.dsfcu_employee a
			where a.department = 'Administration'
			and a.first_name + ' ' + a.last_name = b.name_manager) then 'True'
else 'False'
end as admin_status
 from OnBase.dbo.dsfcu_employee b

 ) d
 where c.department = 'Administration'
 and c.job_description not like '%Assistant%'
 and c.first_name + ' ' + c.last_name = d.name_manager) f
 where e.department = 'Administration'
 and e.job_description not like '%Assistant%'
 and e.first_name + ' ' + e.last_name = f.name_manager
   group by e.sam_account_name,e.first_name, e.last_name, e.name_manager, f.department, e.job_description, e.business_unit
UNION ALL

select g.sam_account_name,g.first_name + ' ' + g.last_name as admin_name, g.name_manager, h.department, g.job_description, g.business_unit
from OnBase.dbo.dsfcu_employee g, (select e.first_name + ' ' + e.last_name as admin_name, e.name_manager, f.department, e.job_description, e.business_unit
from OnBase.dbo.dsfcu_employee e, (select c.first_name + ' ' + c.last_name as admin_name, c.name_manager, d.department, c.job_description, c.business_unit
 from OnBase.dbo.dsfcu_employee c, (select b.name_manager, b.business_unit, b.department,
case when name_manager in (select a.first_name + ' ' + a.last_name as admin
			from OnBase.dbo.dsfcu_employee a
			where a.department = 'Administration'
			and a.first_name + ' ' + a.last_name = b.name_manager) then 'True'
else 'False'
end as admin_status
 from OnBase.dbo.dsfcu_employee b

 ) d
 where c.department = 'Administration'
 and c.job_description not like '%Assistant%'
 and c.first_name + ' ' + c.last_name = d.name_manager) f
 where e.department = 'Administration'
 and e.job_description not like '%Assistant%'
 and e.first_name + ' ' + e.last_name = f.name_manager) h
 where g.department = 'Administration'
 and g.job_description not like '%Assistant%'
 and g.first_name + ' ' + g.last_name = h.name_manager
  group by g.sam_account_name,g.first_name, g.last_name, g.name_manager, h.department, g.job_description, g.business_unit
