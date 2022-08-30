C_REAL:C285(vBalance; vRunningBalance; vSumCredit; vSumdebit; vSumOpeningCredit; vSumOpeningDebit)
C_REAL:C285(vTotalDebit; vTotalCredit)

If (Form event code:C388=On Header:K2:17)
	RELATE ONE:C42([Registers:10]AccountID:6)
	RELATE ONE:C42([Accounts:9]MainAccountID:2)
	If (Level:C101=1)
		vRunningBalance:=0
	End if 
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	RELATE ONE:C42([Registers:10]CustomerID:5)
	vRunningBalance:=vRunningBalance+([Registers:10]Debit:8-[Registers:10]Credit:7)
End if 


If (Form event code:C388=On Printing Break:K2:19)
	vSumCredit:=Subtotal:C97([Registers:10]Credit:7)
	vSumDebit:=Subtotal:C97([Registers:10]Debit:8)
	vOpeningDebit:=[Accounts:9]OpeningDebit:9
	vOpeningCredit:=[Accounts:9]OpeningCredit:8
	vTotalDebit:=vSumDebit+vOpeningDebit
	vTotalCredit:=vSumCredit+vOpeningCredit
	vBalance:=vTotalDebit-vTotalCredit
	
	//colorizeNegs (->vBalance)
End if 

