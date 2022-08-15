C_REAL:C285(vSumTransferIns; vSumTransferOuts)
C_LONGINT:C283(vRowNumber)

If (Form event code:C388=On Printing Detail:K2:18)
	setVisibleIff((vRowNumber%2)=0; "backStripe")
	setVisibleIff((vSumTransferIns>0); "positive")
	setVisibleIff((vSumTransferOuts>0); "negative")
	
End if 
