//%attributes = {}
// this method is called from matchAMLRules method
// it's validation
//checkInit 
// 

// address
checkifKYCFieldMissing([AMLRules:74]requireKYC_Address:38; [Customers:3]Address:7; "Address")
checkifKYCFieldMissing([AMLRules:74]requireKYC_Address:38; [Customers:3]City:8; "City")
checkifKYCFieldMissing([AMLRules:74]requireKYC_Address:38; [Customers:3]Province:9; "Province")
checkifKYCFieldMissing([AMLRules:74]requireKYC_Address:38; [Customers:3]PostalCode:10; "Postal Code")
checkifKYCFieldMissing([AMLRules:74]requireKYC_Address:38; [Customers:3]CountryCode:113; "Country Code")

checkifKYCFieldMissing([AMLRules:74]requireKYC_Citizenship:37; [Customers:3]CitizenshipCountryCode:22; "Citizenship Country Code")
checkifKYCFieldMissing([AMLRules:74]requireKYC_Nationality:36; [Customers:3]CountryOfBirthCode:18; "Nationality Country Code (Birth Country)")

// check DOB missing
Case of 
	: ([AMLRules:74]requireKYC_DOB:25=1)  // mandatory
		checkAddErrorIf(([Customers:3]DOB:5=!00-00-00!); "Customer's 'Date of Birth' (DOB) is mandatory.")
		
	: ([AMLRules:74]requireKYC_DOB:25=2)  // optional 
		checkAddWarningOnTrue(([Customers:3]DOB:5=!00-00-00!); "Customer's 'Date of Birth' (DOB) is left blank.")
End case 


checkifKYCFieldMissing([AMLRules:74]requireKYC_Occupation:24; [Customers:3]Occupation:21; "Occupation")  // occupation
checkifKYCFieldMissing([AMLRules:74]requireKYC_MainPhone:51; [Customers:3]HomeTel:6; "Main Phone")  // main phone 
checkifKYCFieldMissing([AMLRules:74]requireKYC_SS:35; [Customers:3]SIN_No:14; "Social Security or SIN#")  // SIN 

checkifKYCFieldMissing([AMLRules:74]requireKYC_PictureIDNo:26; [Customers:3]PictureID_Number:69; "Picture ID No.")  // picture ID #
checkifKYCFieldMissing([AMLRules:74]requireKYC_PictureIDType:52; [Customers:3]PictureID_Type:70; "Picture ID Type")  // picture ID type
checkifKYCFieldMissing([AMLRules:74]requireKYC_PictureIDNo:26; [Customers:3]PictureID_IssueState:72; "Picture ID Issued State/Province")  // picture ID issue state
//checkifKYCFieldMissing ([AMLRules]requireKYC_PictureIDNo;[Customers]MainPictureID;"Main Picture ID No.")

// missing picture ID expiry date check



// override password and prevent transaction messages

checkAddErrorIf([AMLRules:74]thenPreventTransaction:16; [AMLRules:74]preventionMessage:17)
checkAddWarningOnTrue([AMLRules:74]preventionMessage:17#""; [AMLRules:74]preventionMessage:17)

If ([AMLRules:74]thenAskOverridePassword:18)
	checkIfPasswordMatches([AMLRules:74]overridePassword:19; "This transaction requires an override password.")
End if 



checkifKYCFieldMissing([AMLRules:74]requireInvoiceSOF:42; [Invoices:5]SourceOfFund:68; "Source of funds")
checkifKYCFieldMissing([AMLRules:74]requireInvoicePOT:58; [Invoices:5]AMLPurposeOfTransaction:85; "Purpose of Transaction")


// Third party determination
Case of 
	: ([AMLRules:74]requireInvoiceTPD:41=1)  // mandatory
		checkAddErrorIf([Invoices:5]didAskIfThirdPartyIsInvolved:96=False:C215; "You have to ask about the customer third party")
		
	: ([AMLRules:74]requireInvoiceTPD:41=2)  // optional
		checkAddWarningOnTrue([Invoices:5]didAskIfThirdPartyIsInvolved:96=False:C215; "It is recommended to ask if there is a third party involved. ")
End case 

// checkifKYCFieldMissing ([AMLRules]requireInvoiceTPD;[Invoices]ThirdPartyName;"Third party")

// PEP determination
Case of 
	: ([AMLRules:74]requireInvoicePEP:43=1)  // mandatory
		checkAddErrorIf([Invoices:5]didAskIfCustomerIsPEP:65=False:C215; "You have to ask if the customer is PEP (Politically Exposed)!")
	: ([AMLRules:74]requireInvoicePEP:43=2)  // optional
		checkAddWarningOnTrue([Invoices:5]didAskIfCustomerIsPEP:65=False:C215; "It is recommended to ask if customer is PEP (Politically Exposed)!")
End case 

//READ ONLY([Customers])
checkFieldConstraintsForTable(->[Customers:3]; True:C214)  // check all conditional fields for customers and invoice
//checkFieldConstraintsForTable (->[Invoices];True)