


If (Form event code:C388=On Clicked:K2:4)
	If ((Self:C308->=1) & ([Customers:3]HomeTel:6="") & ([Customers:3]CellPhone:13="") & ([Customers:3]WorkTel:12=""))
		BEEP:C151
		myAlert("You need to enter at least one phone number for the customer")
		Self:C308->:=0
		GOTO OBJECT:C206(*; "Tel")
	Else 
		If ([Customers:3]Address:7="")
			GOTO OBJECT:C206(*; "Address")
		Else 
			GOTO OBJECT:C206(*; "cbAddressOK")
		End if 
	End if 
End if 