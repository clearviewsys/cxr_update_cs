
// Import Rates from Denmark Central Bank.
myConfirm("Are you sure you want to import rates from Denmark Central Bank?"; "Yes"; "No")
If (OK=1)
	importDenmarkCentralBankRates
End if 
