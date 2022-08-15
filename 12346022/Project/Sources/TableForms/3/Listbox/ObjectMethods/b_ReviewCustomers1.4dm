
If (isUserComplianceOfficer)
	// form: ([Customers];"Review_Full")
	modifyRecordTable(->[Customers:3]; "Review_AML")
Else 
	myAlert_ComplianceOfficerOnly
End if 