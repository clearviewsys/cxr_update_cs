//%attributes = {"shared":true}
C_TEXT:C284($oldCustomerID; $newCustomerID)
C_BOOLEAN:C305($GO)
$GO:=True:C214

If (isUserAdministrator)
	checkInit
	
	//$oldName:=myRequest ("Please enter old customer ID (the one to be deleted after merge)";"Enter first customer ID")
	//QUERY([Customers];[Customers]CustomerID=$oldName)
	myAlert("Select the Customer you want to Merge (oldest profile, less complete)")
	pickCustomer(->$oldCustomerID)
	checkAddErrorIf((Records in selection:C76([Customers:3])=0); "No customers found with ID "+$oldCustomerID)
	If ($oldCustomerID="")
		$oldCustomerID:=Request:C163("Old customer ID")
	End if 
	
	pickCustomer(->$newCustomerID)
	checkAddErrorIf((Records in selection:C76([Customers:3])=0); "No customers found with ID "+$newCustomerID)
	If ($newCustomerID="")
		$newCustomerID:=Request:C163("New customer ID")
	End if 
	
	
	checkAddErrorIf($oldCustomerID=$newCustomerID; "Cannot merge a customer into itself.")
	checkAddWarning("Are you sure you want to merge customer "+$oldCustomerID+" into "+$newCustomerID+"?")
	checkIfNullString(->$oldCustomerID; "Old Customer ID"; "WARN")
	checkIfNullString(->$newCustomerID; "New Customer ID")
	
	
	If (isValidationConfirmed)
		//Accounts
		searchAndReplaceStringField(->[Accounts:9]; ->[Accounts:9]CustomerID:20; $oldCustomerID; $newCustomerID)
		
		//AccountsInOut
		searchAndReplaceStringField(->[AccountInOuts:37]; ->[AccountInOuts:37]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		//AML Rules
		searchAndReplaceStringField(->[AMLRules:74]; ->[AMLRules:74]ifCustomerID:10; $oldCustomerID; $newCustomerID)
		
		//Bookings
		searchAndReplaceStringField(->[Bookings:50]; ->[Bookings:50]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		//cashTransactions
		searchAndReplaceStringField(->[CashTransactions:36]; ->[CashTransactions:36]CustomerID:10; $oldCustomerID; $newCustomerID)
		
		//callogs
		searchAndReplaceStringField(->[CallLogs:51]; ->[CallLogs:51]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		//cheques
		searchAndReplaceStringField(->[Cheques:1]; ->[Cheques:1]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		//eWires
		searchAndReplaceStringField(->[eWires:13]; ->[eWires:13]CustomerID:15; $oldCustomerID; $newCustomerID)
		
		//Fee Structures
		searchAndReplaceStringField(->[FeeStructures:38]; ->[FeeStructures:38]CustomerID:5; $oldCustomerID; $newCustomerID)
		
		// INVOICES
		searchAndReplaceStringField(->[Invoices:5]; ->[Invoices:5]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		//itemsInOuts
		searchAndReplaceStringField(->[ItemInOuts:40]; ->[ItemInOuts:40]customerID:6; $oldCustomerID; $newCustomerID)
		
		//Links
		searchAndReplaceStringField(->[Links:17]; ->[Links:17]CustomerID:14; $oldCustomerID; $newCustomerID)
		
		//LinkedDocs
		searchAndReplaceStringField(->[LinkedDocs:4]; ->[LinkedDocs:4]CustomerID:1; $oldCustomerID; $newCustomerID)
		
		//Messages
		searchAndReplaceStringField(->[MESSAGES:11]; ->[MESSAGES:11]FromUserID:5; $oldCustomerID; $newCustomerID)
		searchAndReplaceStringField(->[MESSAGES:11]; ->[MESSAGES:11]toUserID:6; $oldCustomerID; $newCustomerID)
		
		// registers
		searchAndReplaceStringField(->[Registers:10]; ->[Registers:10]CustomerID:5; $oldCustomerID; $newCustomerID)
		
		//Wires
		searchAndReplaceStringField(->[Wires:8]; ->[Wires:8]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		//WireTemplates
		searchAndReplaceStringField(->[WireTemplates:42]; ->[WireTemplates:42]CustomerID:2; $oldCustomerID; $newCustomerID)
		
		
		// CustomerID
		CONFIRM:C162(">> Do you want to delete the old Customer record now ?")
		
		If (OK=1)
			READ WRITE:C146([Customers:3])
			UNLOAD RECORD:C212([Customers:3])
			QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$oldCustomerID)
			//[Customers];"Entry"
			saveRecordToDisk("_merged_deleted_"+$oldCustomerID; ->[Customers:3])
			DELETE SELECTION:C66([Customers:3])
			READ ONLY:C145([Customers:3])
			
		End if 
		
	Else 
		
		myAlert("No record was touched!")
	End if 
Else 
	myAlert_AdminPrivilegeNeeded
End if 