C_LONGINT:C283(cbQuerySelection)

If (cbQuerySelection=0)
	ALL RECORDS:C47([Customers:3])
End if 

findDuplicateRecordsOn2Fields(->[Customers:3]; ->[Customers:3]FullName:40; ->[Customers:3]PictureID_Number:69)
