//%attributes = {}
C_TEXT:C284($linkID)


pickLinkForCustomer(->$linkID; Form:C1466.customerID)

If (OK=1)
	
	// map fields to object
	
	Form:C1466.object.receiverFirstName:=[Links:17]FirstName:2
	Form:C1466.object.receiverLastName:=[Links:17]LastName:3
	// Form.object.receiverMiddleName:="" // no mapping for this
	Form:C1466.object.destinationCountry:=mgCXR_CountryCode2MG([Links:17]countryCode:50; Form:C1466.countries)
	mgFillCountryName("destinationCountryName"; Form:C1466.object.destinationCountry; Form:C1466.countries)
	GOTO OBJECT:C206(*; "sendAmount")
	
	Form:C1466.linkID:=[Links:17]LinkID:1
	
End if 
