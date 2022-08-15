If (Form event code:C388=On Double Clicked:K2:5)
	handledoubleclickevent(->[Links:17])
End if 

If ((Form event code:C388=On Selection Change:K2:29) | (Form event code:C388=On Clicked:K2:4))
	seteWireBeneficiaryInfoFromLink
End if 
