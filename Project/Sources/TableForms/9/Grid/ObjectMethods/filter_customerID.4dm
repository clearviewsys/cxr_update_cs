var $customerID : Text

If (Form event code:C388=On Data Change:K2:15)
	$customerID:=Get edited text:C655
	pickCustomer(->$customerID)
	If (OK=1)
		Form:C1466.filter.customerID:=$customerID
		Form:C1466.customerFullName:=[Customers:3]FullName:40
	End if 
End if 