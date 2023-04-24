C_REAL:C285(vBalance; vTotalDebits; vTotalCredits; vOpeningDebit; vOPeningCredit; vOpeningBalance)
C_REAL:C285(vBalance_1; vTotalDebits_1; vTotalCredits_1; vRunningBalance)
C_POINTER:C301($vOpeningDebit; $vOpeningCredit)

If (Form event code:C388=On Header:K2:17)
	RELATE ONE:C42([Registers:10]AccountID:6)
	getAccountBalanceToDate([Registers:10]AccountID:6; [Registers:10]RegisterDate:2; ->$vOpeningDebit; ->$vOpeningCredit; ->vOpeningDebit; ->vOpeningCredit; ->vOpeningBalance)
	
	//vOpeningDebit:=[Accounts]OpeningDebit
	//vOpeningCredit:=[Accounts]OpeningCredit
	//vOpeningBalance:=vOpeningDebit-vOpeningCredit
	vRunningBalance:=vOpeningBalance
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	RELATE ONE:C42([Registers:10]CustomerID:5)
	vRunningBalance:=vRunningBalance+[Registers:10]Debit:8-[Registers:10]Credit:7
End if 

If (Form event code:C388=On Printing Break:K2:19)
	vSumDebits:=Subtotal:C97([Registers:10]Debit:8)+vOpeningDebit
	vSumCredits:=Subtotal:C97([Registers:10]Credit:7)+vOpeningCredit
	vBalance:=vSumDebits-vSumCredits
	
	vSumDebits_1:=Subtotal:C97([Registers:10]Debit:8)+vOpeningDebit
	vSumCredits_1:=Subtotal:C97([Registers:10]Credit:7)+vOpeningCredit
	vBalance_1:=vSumDebits_1-vSumCredits_1
End if 