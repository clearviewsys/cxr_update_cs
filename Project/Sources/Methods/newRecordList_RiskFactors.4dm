//%attributes = {}
If (isUserComplianceOfficer)
	newRecord(->[List_RiskFactors:132])
Else 
	myAlert_ComplianceOfficerOnly
End if 

