If ([Invoices:5]eWireID:23="")
	Self:C308->:=""
Else 
	
	If ([eWires:13]isPaymentSent:20=True:C214)
		Self:C308->:="Payment has been sent."
	Else 
		Self:C308->:="Payment has been received."
	End if 
	
End if 