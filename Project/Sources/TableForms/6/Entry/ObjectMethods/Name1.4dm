If (Form event code:C388=On Data Change:K2:15)
	myConfirm("Are you sure you want to change the name of the Country to "+[Currencies:6]Country:22+"?")
	If (OK#1)
		[Currencies:6]Country:22:=Old:C35([Currencies:6]Country:22)
	End if 
End if 