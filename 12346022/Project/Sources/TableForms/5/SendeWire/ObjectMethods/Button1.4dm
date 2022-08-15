// send eWire Button

If ((Records in selection:C76([Links:17])=1) & (Records in selection:C76([Accounts:9])=1))
	If (vRemainPaid>0)
		createeWireFromInvoice
	Else 
		myAlert("There is no balance left to be paid.")
	End if 
	
	ARRAY TEXT:C222(arrLinks; 0)
	ARRAY TEXT:C222(arrOurBankAccount; 0)
	
Else 
	myAlert("Both a Link and a Bank Account must be selected.")
	REJECT:C38
End if 
