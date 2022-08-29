toTitleCase(Self:C308)
If ((Form event code:C388=On Data Change:K2:15) & ([Customers:3]AddressUnitNo:148=""))
	splitAddressToUnitStreetFields([Customers:3]Address:7; ->[Customers:3]Address:7; ->[Customers:3]AddressUnitNo:148)
End if 