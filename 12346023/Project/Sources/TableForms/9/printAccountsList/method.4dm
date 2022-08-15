C_REAL:C285(vBalance; vTotalDebit; vTotalCredit)

If (Form event code:C388=On Printing Detail:K2:18)
	vBalance:=getAccountTotalsForPrint([Accounts:9]AccountID:1; ->vTotalDebit; ->vTotalCredit)
End if 