C_REAL:C285(vCashBalance)

If (Form event code:C388=On Printing Detail:K2:18)
	setVisibleIff((vCashBalance<0); "negative")
End if 