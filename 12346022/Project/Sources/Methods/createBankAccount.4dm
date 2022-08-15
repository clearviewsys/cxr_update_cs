//%attributes = {}
// CreateBankAccount (Currency:String;{CashMachineID})
C_TEXT:C284($1; $2)

If (Count parameters:C259=1)
	createAccount(makeBank($1); "Banks"; $1; True:C214; False:C215)
Else 
	createAccount(makeBank($1; $2); "Banks"; $1; True:C214; False:C215)
End if 