If (Form event code:C388=On Double Clicked:K2:5)
	handleAccountsPickButton
End if 

If (Form event code:C388=On Load:K2:1)
	GOTO OBJECT:C206(*; "vSearchText")
End if 