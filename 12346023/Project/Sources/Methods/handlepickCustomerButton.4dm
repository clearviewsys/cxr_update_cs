//%attributes = {}

C_LONGINT:C283(slb_Picker)
C_TEXT:C284(vSearchText)
checkInit
validateCustomerKYC

If (isValidationConfirmed)
	handlePickButton(->[Customers:3]; ->[Customers:3]CustomerID:1; ->slb_Picker; ->vSearchText)
	CLOSE WINDOW:C154(Frontmost window:C447)
	
	
Else 
	REJECT:C38
End if 