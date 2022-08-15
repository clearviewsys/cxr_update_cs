C_LONGINT:C283($fieldPtr)
$fieldPtr:=0
handleTristateCheckBox(Self:C308; ->$fieldPtr; "Address Not Verified"; "Address verified!"; "Address is not available"; Red:K11:4; Blue:K11:7; Grey:K11:15)

If (Form event code:C388=On Clicked:K2:4)
	If (Self:C308->=1)  // we don't want to check the address validity if it's not available
		If (([Customers:3]Address:7="") | ([Customers:3]City:8="") | ([Customers:3]CountryCode:113=""))
			myAlert("The Address is incomplete.")
			Self:C308->:=2
			handleTristateCheckBox(Self:C308; ->$fieldPtr; "Address Not Verified"; "Address verified!"; "Address is not available"; Red:K11:4; Blue:K11:7; Black:K11:16)
			GOTO OBJECT:C206(*; "Address")
		End if 
	End if 
	
End if 

applyFocusRect("focusRect2")
