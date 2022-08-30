
C_TEXT:C284(vCurrency)
If (Form event code:C388=On Load:K2:1)
	If (Self:C308->="")
		Self:C308->:="EUR"
	End if 
End if 
If (Form event code:C388=On Data Change:K2:15)
	
	handleFilterDenomInOuts(VDENOMINATION; vCurrency; puSelection)
End if 