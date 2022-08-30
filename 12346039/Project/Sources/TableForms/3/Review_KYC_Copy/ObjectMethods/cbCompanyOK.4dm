If (Form event code:C388=On Clicked:K2:4)
	If ([Customers:3]HomeTel:6="")
		GOTO OBJECT:C206(*; "Tel")
	Else 
		GOTO OBJECT:C206(*; "cbContactOK")
	End if 
End if 