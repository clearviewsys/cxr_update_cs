If (Form event code:C388=On Clicked:K2:4)
	
	If (([Customers:3]Address:7="") | ([Customers:3]City:8="") | ([Customers:3]CountryCode:113=""))
		BEEP:C151
		myAlert("The Address is incomplete.")
		Self:C308->:=0
		GOTO OBJECT:C206(*; "Address")
	Else 
		GOTO OBJECT:C206(*; "bConfirmContactInfo")
	End if 
	
End if 