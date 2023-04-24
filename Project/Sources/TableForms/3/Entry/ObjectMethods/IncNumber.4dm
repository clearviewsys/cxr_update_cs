
If (Form event code:C388=On Data Change:K2:15)
	isFieldValueUnique(Self:C308; ->[Customers:3]BusinessIncorporationNo:65; "This Business Inc. Number already exist in the database!")
End if 
//handleUniqueFieldObjectMethod (Self;->[Customers]CustomerID;"This Business In. No already exist in the database. This may be a duplicate entry!")
