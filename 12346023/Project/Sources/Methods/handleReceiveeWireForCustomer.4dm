//%attributes = {}
C_LONGINT:C283(veWiresReceived)

If (Records in selection:C76([Customers:3])=1)  // customer is found
	veWiresReceived:=selectActiveeWiresForCustomer([Invoices:5]CustomerID:2)
	setVisibleIff(veWiresReceived>0; "eWiresReceived@")
End if 
