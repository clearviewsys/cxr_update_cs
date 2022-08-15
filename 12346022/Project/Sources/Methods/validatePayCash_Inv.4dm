//%attributes = {}
C_REAL:C285(vTotalAmount; vRemaining)
If (vTotalAmount#[CashTransactions:36]Amount:3)
	checkAddError("Total cash-out must be equal to the sum of cash paid.")
End if 
