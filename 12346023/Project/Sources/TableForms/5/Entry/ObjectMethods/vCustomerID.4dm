/*If (Form event code=On Double Clicked)
C_BOOLEAN($isEnabled)
$isEnabled:=OBJECT Get enabled(Self->)
If ($isEnabled)
Self->:=""
INV_handlevCustomerID(Self)
End if 
Else 

INV_handlevCustomerID(Self)
applyFocusRect
End if */


If ((Form event code:C388=On Double Clicked:K2:5) & (Self:C308->#vCustomerID))
	C_BOOLEAN:C305($isEnabled)
	$isEnabled:=OBJECT Get enabled:C1079(Self:C308->)
	If ($isEnabled)
		Self:C308->:=""
		INV_handlevCustomerID(Self:C308)
	End if 
Else 
	
	INV_handlevCustomerID(Self:C308)
	applyFocusRect
End if 
