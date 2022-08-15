If ((Form event code:C388=On Load:K2:1) & (Record number:C243([Currencies:6])<0))
	Self:C308->:=True:C214
End if 

If ((Form event code:C388=On Data Change:K2:15) & (Self:C308->=True:C214))
	handleAutoUpdateRates
End if 