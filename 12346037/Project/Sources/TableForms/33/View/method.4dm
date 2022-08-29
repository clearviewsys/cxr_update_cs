// Cash Registers View form methods

handleViewForm

If (Form event code:C388=On Load:K2:1)
	READ WRITE:C146([CashInventory:35])
	
End if 

If (Form event code:C388#On Clicked:K2:4)
	relateMany(->[CashAccounts:34]; ->[CashAccounts:34]CashRegisterID:2; ->[CashRegisters:33]CashRegisterID:1)
	handleFilterCashInventory
End if 

calcSumVarsInCashRegistersView  // calculates the sum
