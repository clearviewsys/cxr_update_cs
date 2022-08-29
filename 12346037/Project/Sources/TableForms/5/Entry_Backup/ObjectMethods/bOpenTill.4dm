checkInit
setCustomerToSelf

If (isValidationConfirmed)
	If (isUserAllowedToTransfer)
		openFormWindow(->[CompanyInfo:7]; "openTill")
		CLOSE WINDOW:C154
		
	Else 
		ALERT:C41("Please ask the administrator to grant you access to transfer between accounts.")
	End if 
End if 