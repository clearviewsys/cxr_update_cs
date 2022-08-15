//%attributes = {}
If (isDuringInvoice)
	validateAccountPickedInInvoice
End if 


If (Not:C34([eWires:13]isCancelled:34))
	
	//checkIfNullString (->[eWires]_CustomerName;"Sender Name")  ` for mandatory strings
	checkIfNullString(->[eWires:13]LinkID:8; "Link ID"; "warn")
	//checkIfNullString (->[eWires]RegisterID;"Register ID")
	checkIfNullString(->[eWires:13]InvoiceNumber:29; "Invoice ID"; "Warn")
	
	If ([eWires:13]isPaymentSent:20)  // when sending money
		checkIfNullString(->[eWires:13]toCountryCode:112; "To Country Code")  // 
		checkLowerBound(->[eWires:13]ToAmount:14; "To Amount"; 0)
		checkIfNullString(->[eWires:13]Currency:12; "To Currency")
		checkifAccountisOfCurrency([eWires:13]AccountID:30; [eWires:13]Currency:12)
		checkIfNullString(->[eWires:13]fromMOP_Code:113; "Method of Payment Received")  // mandatory for everyone
		
		checkIfNullString(->[eWires:13]BeneficiaryFullName:5; "Beneficiary Name")
		checkIfNullString(->[eWires:13]BeneficiaryRelationship:64; "Beneficiary Relationship"; "warn")
		checkIfNullString(->[eWires:13]BeneficiaryCity:60; "Beneficiary City"; "warn")
		
		Case of 
			: ([eWires:13]doTransferToBank:33)
				checkIfNullString(->[eWires:13]BeneficiaryBankName:76; "Beneficiary Bank Name")
				checkIfNullString(->[eWires:13]BeneficiaryBankAccountNo:66; "Beneficiary Bank Account NO.")
			: (getKeyValue("ewires.tomop.mobilewallet")=[eWires:13]toMOP_Code:114)  //Lotus
				checkIfNullString(->[eWires:13]BeneficiaryCellPhone:61; "Beneficiary Cell Phone")
			Else 
				If ([eWires:13]isSettled:23)
					checkIfNullString(->[eWires:13]ReferenceNo:28; "Agent Confirmation No.")
					checkIfNullString(->[eWires:13]AgentInternalRef:40; "Agent Invoice No."; "WARN")
				End if 
		End case 
		
		If ([eWires:13]isSettled:23)  // if the money is paid (in overseas)
			checkIfAccountIsForSettlement([eWires:13]AccountID:30; True:C214)  // money must have been deposited into a valid foreign account
			checkGreaterThan(->[eWires:13]sourceRate:41; "Exchange rate"; 0)
		End if 
		
	Else   // when receiving money
		checkAddWarningOnTrue([eWires:13]isSettled:23=False:C215; "Are you sure this remittance is not settled (still pending payment)?")
		checkIfNullString(->[eWires:13]fromCountryCode:111; "From Country Code")  // 
		checkGreaterThan(->[eWires:13]FromAmount:13; "From Amount"; 0)
		checkIfNullString(->[eWires:13]FromCurrency:11; "From Currency"; "WARN")
		checkifAccountisOfCurrency([eWires:13]AccountID:30; [eWires:13]Currency:12)  // modified by TB on March 30/2015
		
		If ([eWires:13]isSettled:23)  // if the money is paid (in here)
			checkIfNullString(->[eWires:13]InvoiceNumber:29; "Our Invoice No.")
			checkIfAccountIDExists(->[eWires:13]AccountID:30; "Foreign Account")  // foreign account must be a valid account
			checkGreaterThan(->[eWires:13]sourceRate:41; "Exchange rate"; 0)
		End if 
		
	End if 
	
	checkIfAccountIDExists(->[eWires:13]AccountID:30; "Foreign Account")  // check if the foreign account exists in the system
	
	If ([eWires:13]doNotifyBySMS:31)
		checkIfNullString(->[eWires:13]BeneficiaryCellPhone:61; "Cellphone number for beneficiary")
	End if 
	//TRACE
	
	If ([eWires:13]doTransferToBank:33)
		checkIfNullString(->[eWires:13]BeneficiaryBankName:76; "Beneficiary Bank Name")
		checkIfNullString(->[eWires:13]BeneficiaryBankAccountNo:66; "Beneficiary Bank Account No")
		
	End if 
	
	If ([eWires:13]doDeliverToAddress:32)
		checkIfNullString(->[eWires:13]DeliveryAddress:37; "Delivery address")
	End if 
	
	If (([eWires:13]doTransferToBank:33) & ([eWires:13]doDeliverToAddress:32))
		checkAddError("Cannot 'transfer to account' and 'deliver to address' at the same time.")
	End if 
	
	If ([eWires:13]priority:36=2)
		checkIfNullString(->[eWires:13]CustomerMsg:16; "(Urgent Message) Special Instructions")
	End if 
End if 

If (([eWires:13]ReferenceNo:28#"") & Not:C34([eWires:13]isSettled:23))  // cannot have an ewire not paid but with agent confirmation number
	checkAddWarning("This ewire has already been confirmed, therefore should have been previously paid")
End if 

If ((Old:C35([eWires:13]isSettled:23)=True:C214) & ([eWires:13]isSettled:23=False:C215))
	checkAddError("This eWire was previously PAID, therefore you cannot change it to unpaid!")
End if 

checkAddErrorIf(([eWires:13]amountLocal:45=0); "Local amount cannot be zero")

If (Is new record:C668([eWires:13]))  // THIS IS NEW - ADDED IN VERSION 4.440 BY TIRAN ON MAY 1ST/2-15
	
Else 
	// do not allow changing of local amount when eWire is being edited
	checkAddErrorIf((Old:C35([eWires:13]amountLocal:45)#([eWires:13]amountLocal:45)); "Local Amount Cannot be changed")
	// do not allow changing of beneficiary when eWire is being edited
	checkAddErrorIf(([eWires:13]LinkID:8#Old:C35([eWires:13]LinkID:8)); "Counter Party cannot be changed during modification")
	//checkadderrorif((old([eWires]isLocked=true));"Cannot make modifications to a record that has been fetched already")
End if 
