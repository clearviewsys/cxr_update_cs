//%attributes = {}
C_LONGINT:C283(slb_picker)
C_TEXT:C284(vSearchText)

checkInit

validateAccountPickedInInvoice

If (isValidationConfirmed)
	handlePickButton(->[Accounts:9]; ->[Accounts:9]AccountID:1; ->slb_picker; ->vSearchText)
	ACCEPT:C269
Else 
	REJECT:C38
End if 


