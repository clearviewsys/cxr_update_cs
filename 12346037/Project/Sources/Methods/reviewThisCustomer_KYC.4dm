//%attributes = {}
// reviewCustomerProfile 
// this method opens the customer review profile page in the same proces
C_TEXT:C284($thisCustomer)
C_BOOLEAN:C305($isReadOnly)

$thisCustomer:=[Customers:3]CustomerID:1
If ([Customers:3]CustomerID:1#"")
	$isReadOnly:=Read only state:C362([Customers:3])
	
	READ WRITE:C146([Customers:3])
	LOAD RECORD:C52([Customers:3])
	
	If (Locked:C147([Customers:3]))
		myAlert("The customer record is currently locked. Please try again later.")
	Else 
		openFormWindow(->[Customers:3]; "Review_KYC")
	End if 
	
	If ($isReadOnly)
		UNLOAD RECORD:C212([Customers:3])
		READ ONLY:C145([Customers:3])
		LOAD RECORD:C52([Customers:3])
	End if 
	
Else 
	myAlert("No customer profile selected!")
End if 