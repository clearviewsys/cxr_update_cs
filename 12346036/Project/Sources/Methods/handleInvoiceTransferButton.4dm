//%attributes = {}
checkInit
setCustomerToSelf
If (isValidationConfirmed)
	If (isUserAllowedToTransfer)
		[Invoices:5]isTransfer:42:=True:C214
		displayTransferFunds_
	Else 
		myAlert("Please ask the administrator to grant you access to transfer between accounts.")
	End if 
	
End if 

relateManyRegistersForInvoice
REDRAW WINDOW:C456
