pickCustomerTypes(->[Invoices:5]CustomerTypeID:92; True:C214)
If (OK=1)
	C_POINTER:C301($CustomerTypeDDPtr)
	$CustomerTypeDDPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "CustTypeDD")
	If (Not:C34(Is nil pointer:C315($CustomerTypeDDPtr)))
		handleInvoiceCustomerTypeDD($CustomerTypeDDPtr; ->[Invoices:5]CustomerTypeID:92; On Load:K2:1)
	End if 
End if 