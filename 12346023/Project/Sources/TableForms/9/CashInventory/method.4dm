C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)
If (Form event code:C388=On Load:K2:1)
	vFromDate:=Current date:C33
	vToDate:=Current date:C33
	cbApplyDateRange:=1
	
	acc_fillPositionsListBox
End if 

