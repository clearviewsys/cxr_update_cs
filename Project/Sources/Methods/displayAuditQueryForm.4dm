//%attributes = {"shared":true}
// displayAuditQueryForm

C_LONGINT:C283(vRegisterWindowRef)
vRegisterWindowRef:=Current form window:C827
If (isUserManager | isUserComplianceOfficer)
	openFormWindow(->[Registers:10]; "AuditQueryForm")
Else 
	myAlert("This feature Restricted to managers and compliance officers only!")
End if 