//%attributes = {}
C_BOOLEAN:C305(<>doFINTRACChecks)
If ([Links:17]isCompany:43)
	checkIfNullString(->[Links:17]CompanyName:42; "Company Name")
	checkIfStringLengthIsGT(->[Links:17]CompanyName:42; 4; True:C214; "Company Name")
Else 
	
	checkIfNullString(->[Links:17]FirstName:2; "First Name")  // for mandatory strings
	checkIfStringLengthIsGT(->[Links:17]FirstName:2; 2; True:C214; "First Name")
	
	checkIfNullString(->[Links:17]LastName:3; "Last Name")  // for mandatory strings
	checkIfStringLengthIsGT(->[Links:17]LastName:3; 2; True:C214; "Last Name")
End if 

checkIfNullString(->[Links:17]countryCode:50; "Country Code")  // for mandatory strings

If ([Links:17]isAccount:51)
	checkIfNullString(->[Links:17]BankName:28; "Bank Name")
	checkIfNullString(->[Links:17]BankAccountNo:31; "Bank Account/ IBAN")
	checkIfNullString(->[Links:17]BankSwift:62; "Bank SWIFT"; "WARN")
	checkIfNullString(->[Links:17]BankTransitCode:29; "Bank Transit"; "WARN")
	
Else 
	
	//checkIfNullString (->[Links]AuthorizedUser;"Authorized eWire Partner")
	checkIfNullString(->[Links:17]CustomerID:14; "Customer ID"; "WARN")  // for mandatory strings
	
	//checkIfNullString (->[Links]City;"City";"warn")
	checkIfNullString(->[Links:17]Relationship:26; "Relationship"; "warn")
	
	
	If ((<>doFINTRACChecks) & ([Links:17]Address:19=""))
		checkAddWarning("COMPLIANCE: Link Address is missing!")
	End if 
	
	If ((<>doFINTRACChecks) & ([Links:17]Province:60=""))
		checkAddWarning("COMPLIANCE: Province is missing!")
	End if 
	
	If ((<>doFINTRACChecks) & ([Links:17]PostalCode:61=""))
		checkAddWarning("COMPLIANCE: Postal Code/Zip Code is missing!")
	End if 
	
	
	If (([Links:17]UnconfirmedCustomerName:18#"") & ([Links:17]UnconfirmedCustomerName:18#[Links:17]CustomerName:15))
		//checkAddWarning ("Make sure that '"+[Links]UnconfirmedCustomerName+"' is the same person as "+[Links]CustomerName)
	End if 
End if 