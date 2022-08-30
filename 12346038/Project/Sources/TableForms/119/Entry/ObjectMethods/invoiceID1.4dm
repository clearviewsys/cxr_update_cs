If (Form event code:C388=On Data Change:K2:15)
	
	pickCustomer(Self:C308)
	relateOne(->[Customers:3]; ->[AML_Reports:119]CustomerID:19; ->[Customers:3]CustomerID:1)
	If (Records in selection:C76([Customers:3])=1)
		[AML_Reports:119]NameOfSubject:20:=[Customers:3]FullName:40
		// load all the invoices connected to that customer
		QUERY:C277([Invoices:5]; [Invoices:5]CustomerID:2=Self:C308->)  // load the related invoices
		ARRAY TEXT:C222(arrInvoices; 0)
		SELECTION TO ARRAY:C260([Invoices:5]InvoiceID:1; arrInvoices)
	Else 
		BEEP:C151
		Self:C308->:=""
	End if 
End if 