//%attributes = {}
// handleInvoiceCloseTill

checkInit
setCustomerToSelf
If (isValidationConfirmed)
	transferTillToSafe
	relateManyRegistersForInvoice
	REDRAW WINDOW:C456
End if 
