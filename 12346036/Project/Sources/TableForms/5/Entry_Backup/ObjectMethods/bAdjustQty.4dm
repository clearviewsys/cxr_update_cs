checkInit
setCustomerToSelf
checkAddErrorIf(Not:C34(isUserAdministrator); "User must be administrator")

If (isValidationConfirmed)
	If (isUserAllowedToTransfer)
		openFormWindow(->[CompanyInfo:7]; "AdjustAccountBalances")
		CLOSE WINDOW:C154
		
	Else 
		myAlert("Please ask the administrator to grant you access to transfer between accounts.")
	End if 
	
End if 