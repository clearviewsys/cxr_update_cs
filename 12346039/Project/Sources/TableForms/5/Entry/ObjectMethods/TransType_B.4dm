pickTransactionTypes(->[Invoices:5]TransactionTypeID:91; True:C214)
If (OK=1)
	C_POINTER:C301($transTypeDDPtr)
	$transTypeDDPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "TransTypeDD")
	handleInvoiceTransactionTypeDD($transTypeDDPtr; ->[Invoices:5]TransactionTypeID:91; On Load:K2:1)
End if 