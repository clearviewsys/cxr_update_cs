C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)

If (Form event code:C388=On Load:K2:1)
	ewr_filleWiresListBox
	GOTO OBJECT:C206(*; "filterString")
End if 