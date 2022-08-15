C_LONGINT:C283($fieldPtr)  // isGeneralInfoChecked
$fieldPtr:=0
handleTristateCheckBox(Self:C308; ->$fieldPtr; "Phone & email Not Verified"; "Phone & email verified!"; "Phone & email not available"; Red:K11:4; Blue:K11:7; Black:K11:16)

If (Form event code:C388=On Clicked:K2:4)
	If ((Self:C308->=1) & ([Customers:3]HomeTel:6="") & ([Customers:3]CellPhone:13="") & ([Customers:3]WorkTel:12=""))
		BEEP:C151
		myAlert("You need to enter at least one phone number for the customer")
		Self:C308->:=0
		
		handleTristateCheckBox(Self:C308; ->$fieldPtr; "Phone & email Not Verified"; "Phone & email verified!"; "Phone & email not available"; Red:K11:4; Blue:K11:7; Black:K11:16)
		GOTO OBJECT:C206(*; "Tel")
	End if 
End if 
applyFocusRect