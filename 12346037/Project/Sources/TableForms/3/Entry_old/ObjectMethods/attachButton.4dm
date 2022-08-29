checkInit
validateCustomers
If (isValidationConfirmed)
	setNextCustomer([Customers:3]CustomerID:1)
	PUSH RECORD:C176([Customers:3])
	newRecordLinkedDocs
	POP RECORD:C177([Customers:3])
	relateManyLinkedDocs
End if 