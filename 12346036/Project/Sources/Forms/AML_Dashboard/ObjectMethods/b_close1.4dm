If (cbApplyDateRange=1)
	applyAMLRulesToInvoices(newDateRange(vFromDate; vToDate))
Else 
	applyAMLRulesToInvoices
End if 