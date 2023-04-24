If (cbApplyDateRange=1)
	agg_applyRulesToInvoices(newDateRange(vFromDate; vToDate))
Else 
	agg_applyRulesToInvoices
End if 