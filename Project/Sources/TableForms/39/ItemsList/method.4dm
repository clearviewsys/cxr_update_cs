C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)
If (Form event code:C388=On Load:K2:1)
	selectItemsInOutInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	itm_fillItemsListBox
	
End if 