C_POINTER:C301($tablePtr)
$tablePtr:=getAMLDashboardTabTablePtr
If (Not:C34(Is nil pointer:C315($tablePtr)))
	tbar_SaveSet($tablePtr)
End if 
