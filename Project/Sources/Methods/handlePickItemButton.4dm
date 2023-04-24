//%attributes = {}
// handlePickitemButton

C_LONGINT:C283(slb_Picker)
C_TEXT:C284(vSearchText)
checkInit
//handlepickcustomerbutton


If (isValidationConfirmed)
	handlePickButton(->[Items:39]; ->[Items:39]ItemID:1; ->slb_Picker; ->vSearchText)
	CLOSE WINDOW:C154(Frontmost window:C447)
Else 
	REJECT:C38
End if 