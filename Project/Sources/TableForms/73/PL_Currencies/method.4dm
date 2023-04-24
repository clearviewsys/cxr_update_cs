
C_LONGINT:C283(cbShowInverseRates)

If (Form event code:C388=On Load:K2:1)
	
End if 

If (Form event code:C388=On Outside Call:K2:11)
	PL_fillSummaryRows(vFromDate; vToDate; vBranchID; numToBoolean(cbShowInverseRates))
End if 

If (Form event code:C388=On Unload:K2:2)
	PL_initListBoxDetailArrays
	PL_initListBoxSummaryArrays
End if 
