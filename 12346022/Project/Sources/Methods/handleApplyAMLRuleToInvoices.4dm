//%attributes = {}
If (isUserComplianceOfficer)
	
	requestDateRange
	If (OK=1)
		C_DATE:C307(vFromDate; vToDate)
		C_OBJECT:C1216($dateRange)
		$dateRange:=newDateRange(vFromDate; vToDate)
		applyAMLRulesToInvoices($dateRange)
	End if 
	
Else 
	myAlert_AccessDenied
End if 