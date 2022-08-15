//%attributes = {}


checkUniqueKey(->[Cheques:1]; ->[Cheques:1]ChequeID:1; "Cheque ID")
checkIfNullString(->[Cheques:1]ChequeNumber:4; "Cheque Number"; "WARN")
checkGreaterThan(->[Cheques:1]Amount:8; "Cheque Amount"; 0)
checkIfAccountIDExists(->[Cheques:1]AccountID:7)
checkifAccountisOfCurrency([Cheques:1]AccountID:7; [Cheques:1]Currency:9)

checkIfValidDate(->[Cheques:1]DueDate:3; "Due Date")
checkIfValidDate(->[Cheques:1]IssueDate:16; "Issue Date")
If ([Cheques:1]IssueDate:16>[Cheques:1]DueDate:3)
	checkAddError("Issue date must be before cheque date.")
End if 

checkIfNullString(->[Cheques:1]PayTo:15; "To the order of")
checkifRecordExists(->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[Cheques:1]AccountID:7; "Account ID")

If ([Cheques:1]DueDate:3>Current date:C33)
	checkAddWarning("Please make sure this is a postdated cheque.")
	// now check to see if check is post dated it must be 
	checkifStringsEqual(->[Cheques:1]AccountID:7; "Account ID: "+[Cheques:1]AccountID:7; makeChequeAccountID([Cheques:1]Currency:9; [Cheques:1]isPaid:11); "WARNING")
End if 

If ([Cheques:1]isPaid:11)  // if we paid the cheque
	checkifStringsEqual(->[Cheques:1]PayTo:15; "'Pay To the order of'"; [Customers:3]FullName:40; "WARNING")
Else   // if we received the cheque
	checkifStringsEqual(->[Cheques:1]PayTo:15; "'Pay To the order of'"; <>CompanyName; "WARNING")
	
	//checkIfNullString (->[Cheques]Bank;"Issuer Bank";"WARNING")
End if 

Case of 
	: ([Cheques:1]chequeStatus:14=0)  // Pending then account must be either payable or receivable
		checkifStringsEqual(->[Cheques:1]AccountID:7; [Cheques:1]AccountID:7; makeChequeAccountID([Cheques:1]Currency:9; [Cheques:1]isPaid:11); "WARN")
		
	: ([Cheques:1]chequeStatus:14=1)  // Deposited. then account must  be a bank account
		checkIfAccountIsBankAccount([Cheques:1]AccountID:7; True:C214)
		checkIfValidDate(->[Cheques:1]DepositDate:17; "Deposit Date")
		If ([Cheques:1]DueDate:3>(1+Current date:C33))
			checkAddWarning("This cheque should be cleared after "+String:C10([Cheques:1]DueDate:3))
		End if 
	: ([Cheques:1]chequeStatus:14=2)  // Returned. must not be a bank account
		checkIfAccountIsBankAccount([Cheques:1]AccountID:7; False:C215)
		
End case 