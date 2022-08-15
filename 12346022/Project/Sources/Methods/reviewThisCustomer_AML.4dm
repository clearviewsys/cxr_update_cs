//%attributes = {}
// reviewCustomer 

// this is a full review of the customer profile and activities
If (isUserComplianceOfficer)
	C_TEXT:C284($thisCustomer)
	$thisCustomer:=[Customers:3]CustomerID:1
	If ([Customers:3]CustomerID:1#"")
		READ WRITE:C146([Customers:3])
		LOAD RECORD:C52([Customers:3])
		openFormWindow(->[Customers:3]; "Review_AML")
	Else 
		myAlert("No customer profile selected!")
	End if 
	
Else 
	myAlert_ComplianceOfficerOnly
End if 