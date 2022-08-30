//%attributes = {}
If (isUserComplianceOfficer)
	newRecord(->[List_PIN:130])
Else 
	myAlert_ComplianceOfficerOnly
End if 