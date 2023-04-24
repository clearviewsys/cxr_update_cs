//%attributes = {}
// handleApplyAMLRuleToInvoices
// this method is called from a button in the AML_Alerts
// it runs the AML rules on a date range of invoices
// written by @tiran

If (isUserComplianceOfficer)
	
	requestDateRange
	If (OK=1)
		C_DATE:C307(vFromDate; vToDate)
		C_OBJECT:C1216($dateRange)
		$dateRange:=newDateRange(vFromDate; vToDate)
		agg_applyRulesToInvoices($dateRange)
	End if 
	
Else 
	myAlert_ComplianceOfficerOnly
End if 