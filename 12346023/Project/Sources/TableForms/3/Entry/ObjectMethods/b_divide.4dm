If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($mixedStreetAddress)
	$mixedStreetAddress:=[Customers:3]Address:7
	If (($mixedStreetAddress#"") & ([Customers:3]AddressUnitNo:148=""))
		splitAddressToUnitStreetFields($mixedStreetAddress; ->[Customers:3]Address:7; ->[Customers:3]AddressUnitNo:148)
	End if 
End if 