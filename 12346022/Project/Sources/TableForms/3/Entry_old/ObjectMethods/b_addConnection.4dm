checkInit
validateCustomers
If (isValidationConfirmed)
	setNextCustomer([Customers:3]CustomerID:1)
	PUSH RECORD:C176([Customers:3])
	newRecordCSMRelations
	POP RECORD:C177([Customers:3])
	relateManyCSMRelations
End if 