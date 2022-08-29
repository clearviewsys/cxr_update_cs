checkInit

setCustomerToSelf

If (isValidationConfirmed)
	
	If (isUserAllowedToTransfer)
		openFormWindow(->[Invoices:5]; "AdjustAccounts")
		CLOSE WINDOW:C154
	Else 
		myAlert("Please ask the administrator to grant you access to transfer between accounts."; "Privilege Restriction")
	End if 
End if 