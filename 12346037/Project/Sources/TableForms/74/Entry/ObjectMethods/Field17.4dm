If (Form event code:C388=On Clicked:K2:4)
	If ([AMLRules:74]ifCustomerIsOnSanction:39)
		[AMLRules:74]thenSetAsSTR:46:=True:C214
	End if 
End if 