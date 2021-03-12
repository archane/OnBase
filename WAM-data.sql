select prop.propertyvalue from onbase.hsi.approvalpath ap,onbase.hsi.approvalcondition ac,onbase.hsi.approvalconditionprops prop
where ap.approvalprocnum in(102,104,105)
and ap.approvalrulenum = ac.approvalrulenum
and ac.approvalcondnum = prop.approvalcondnum
and prop.propertyname = 'Value'
and prop.propertyvalue LIKE '_filter_%'
order by prop.propertyvalue asc
