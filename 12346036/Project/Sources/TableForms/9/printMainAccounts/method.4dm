C_REAL:C285(vTotalDebits; vTotalCredits; vDeposits; vWithdrawals; vBalance)

Case of 
	: (Form event code:C388=On Header:K2:17)
		READ ONLY:C145([MainAccounts:28])
		READ ONLY:C145([Accounts:9])
		READ ONLY:C145([Registers:10])
		
		RELATE ONE:C42([Accounts:9]MainAccountID:2)  // load MainAccount ID
		vTotalDebits:=0
		vTotalCredits:=0
	: (Form event code:C388=On Printing Detail:K2:18)
		C_REAL:C285(vDeposits; vWithdrawals; vBalance; vTotalDebits; vTotalCredits)
		RELATE MANY:C262([Accounts:9]AccountID:1)  // load registers
		sumSelectionOn2Fields(->[Registers:10]; ->[Registers:10]Debit:8; ->[Registers:10]Credit:7; ->vDeposits; ->vWithdrawals)
		vDeposits:=vDeposits+[Accounts:9]OpeningDebit:9
		vBalance:=vDeposits-vWithdrawals
		vTotalDebits:=vTotalDebits+vDeposits
		vTotalCredits:=vTotalCredits+vWithdrawals
		colorizeNegs(->vBalance)
	: (Form event code:C388=On Printing Break:K2:19)
		vBalance:=vTotalDebits-vTotalCredits
		
End case 
