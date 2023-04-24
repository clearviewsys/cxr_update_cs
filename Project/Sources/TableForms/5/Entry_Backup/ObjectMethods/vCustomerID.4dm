If (Form event code:C388=On Double Clicked:K2:5)
	C_BOOLEAN:C305($isEnabled)
	$isEnabled:=OBJECT Get enabled:C1079(Self:C308->)
	If ($isEnabled)
		Self:C308->:=""
		INV_handlevCustomerID
	End if 
Else 
	
	INV_handlevCustomerID
	applyFocusRect
End if 


