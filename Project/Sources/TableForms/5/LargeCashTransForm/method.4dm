
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
If ([Invoices:5]ThirdPartyisInvolved:22=True:C214)
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[Invoices:5]InvoiceID:1)
	C_TEXT:C284(tThirPartyFullName)
	tThirPartyFullName:=makeFullName([ThirdParties:101]FirstName:4; [ThirdParties:101]LastName:3)
End if 
