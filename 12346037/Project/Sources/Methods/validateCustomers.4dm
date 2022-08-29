//%attributes = {}
// validateCustomers(inReview)

C_BOOLEAN:C305(<>doCheckCustomerProfile; $inReview; $1)

Case of 
	: (Count parameters:C259=0)
		$inReview:=False:C215
	: (Count parameters:C259=1)
		$inReview:=$1
	Else 
End case 


Case of 
	: ([Customers:3]isCompany:41)
		
		If (Is new record:C668([Customers:3]))  // new record
			checkUniqueKey(->[Customers:3]; ->[Customers:3]CustomerID:1; "Customer ID")
			checkUniqueKey(->[Customers:3]; ->[Customers:3]CompanyName:42; "Company Name"; "Warn")
			
			If ([Customers:3]isMSB:85)  //per lotus
				checkUniqueKey(->[Customers:3]; ->[Customers:3]MSBRegistrationNo:88; "MSB Registration No."; "Warn")
			End if 
			checkUniqueKey(->[Customers:3]; ->[Customers:3]BusinessIncorporationNo:65; "Business Incorporation No.")
			
			If ([Customers:3]NIC:152="")  //per lotus
			Else 
				checkUniqueKey(->[Customers:3]; ->[Customers:3]NIC:152; "NIC (National Information Centre)")
			End if 
		End if 
		
		checkIfNullString(->[Customers:3]CompanyName:42; "Company Name")
		checkIfStringLengthIsGT(->[Customers:3]CompanyName:42; 3; True:C214; "Company Name")
	Else 
		checkIfNullString(->[Customers:3]FirstName:3; "First Name")
		checkIfNullString(->[Customers:3]LastName:4; "Last Name")
		
End case 

If (([Customers:3]isOnHold:52) & ([Customers:3]isAllowedInternetAccess:50))
	checkAddError("A Customer who is on hold must NOT be allowed access through internet.")
End if 

If ([Customers:3]isCompany:41)
	[Customers:3]FullName:40:=[Customers:3]CompanyName:42
Else 
	[Customers:3]FullName:40:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
End if 

checkIfModified(->[Customers:3]FullName:40; "CAUTION: You have modified the full name of this customer."; "WARN")

checkUniqueKey(->[Customers:3]; ->[Customers:3]PictureID_Number:69; "Main PictureID")
checkUniqueKey(->[Customers:3]; ->[Customers:3]SIN_No:14; "This Social Security (or SIN)")
//checkUniqueKey(->[Customers];->[Customers]Email;"Email")
checkUniqueKey(->[Customers:3]; ->[Customers:3]ExternalAccountNo:96; "Account No")

If (Not:C34(isFieldUnique(->[Customers:3]Email:17; ->[Customers:3]CustomerID:1)))  // email cannot be verified with the checkUniqueKey
	checkAddError("email address is not unique!")
End if 

checkAddWarningOnTrue([Customers:3]AML_doNotReport:153; "This Customer's Transaction will not be reported to authorities!")

C_LONGINT:C283($imageSize)
$imageSize:=Picture size:C356([Customers:3]PictureID_Image:53)/1000

checkAddWarningOnTrue($imageSize>200; "Size of scanned picture is larger than 200K")
checkAddErrorIf($imageSize>500; "Size of scanned picture must be less than 500K")

If (([Customers:3]isAccount:34) | ([Customers:3]AML_ignoreKYC:35))
	checkAddWarning("KYC checks are ignored for Customer type 'Accounts' or 'ignore KYC' checked!")
Else 
	// KYC Checks don't make sense for Accounts
	If (Old:C35([Customers:3]Email:17)#[Customers:3]Email:17) & (Is new record:C668([Customers:3])=False:C215)  //temp for Lotus correcting old email address
		//existing record where email has been udpated
	Else 
		validateKYC($inReview)
		checkCustomerPictureID
		
		validateCustomers_NZ
	End if 
	
End if 
checkAddErrorIf([Customers:3]isWalkin:36=True:C214; "Cannot modify the Walk-in Customer")
checkAddErrorIf(([Customers:3]isOnHold:52#Old:C35([Customers:3]isOnHold:52)) & ([Customers:3]AML_OnHoldNotes:127=""); "Please enter a reason for placing customer on hold/off hold!")
checkAddErrorIf(([Customers:3]AML_isSuspicious:49#Old:C35([Customers:3]AML_isSuspicious:49)) & ([Customers:3]AML_SuspiciousNotes:125=""); "Please enter a reason for marking the customer as suspicious (or not)!")
