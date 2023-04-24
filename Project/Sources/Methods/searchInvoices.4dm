//%attributes = {}

C_TEXT:C284($1)

Case of 
	: (Count parameters:C259=0)
		// do nothing but don't delete this case as it will cause an assertion failure
	: (Count parameters:C259=1)
		vSearchString:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//searchTable (->[Invoices];->[Invoices]InvoiceNumber;->[Invoices]AutoComments;->[Invoices]TransactionType;->[Invoices]printRemarks;->[Invoices]ActingOnBehalfOf;->[Invoices]comments)` disabled the last field for improving speed
searchTable(->[Invoices:5]; ->[Invoices:5]InvoiceID:1; ->[Invoices:5]TransactionTypeID:91; ->[Invoices:5]CustomerID:2; ->[Invoices:5]CustomerTypeID:92; ->[Invoices:5]printRemarks:16; ->[Invoices:5]ThirdPartyName:29; ->[Invoices:5]CustomerFullName:54; ->[Invoices:5]_Sync_ID:79)


