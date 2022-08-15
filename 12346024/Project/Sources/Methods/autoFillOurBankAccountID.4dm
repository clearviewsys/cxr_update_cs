//%attributes = {}
If ([Registers:10]isReceived:13)
	// the currency received must be the same as the currency of the account we put it in
	
	If ([Accounts:9]Currency:6#[Invoices:5]fromCurrency:3)
		myAlert("this account cannot take "+[Invoices:5]fromCurrency:3)
		[Registers:10]AccountID:6:=""
	Else 
	End if 
	
Else   // payment made must be from an account compatible to amoutPaidToCustomer
	
	If ([Accounts:9]Currency:6#[Invoices:5]toCurrency:8)
		myAlert("this account cannot pay "+[Invoices:5]toCurrency:8)
		[Registers:10]AccountID:6:=""
	End if 
End if 
