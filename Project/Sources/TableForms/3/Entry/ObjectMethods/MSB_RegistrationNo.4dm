
If (Form event code:C388=On Data Change:K2:15)
	isFieldValueUnique(Self:C308; ->[Customers:3]MSBRegistrationNo:88; "MSB Registration already exist! This is a duplicate entry!")
End if 

