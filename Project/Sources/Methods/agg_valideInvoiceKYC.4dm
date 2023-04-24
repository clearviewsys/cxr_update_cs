//%attributes = {}
// agg_validateInvoiceKYC
// formerly called: checkCustomerKYCRequirements ( ruleEntity; customerEntity)
// this method is called from the validation of an Invoice
// it checks the rules against the customer entity and validate missing KYC attributes

C_OBJECT:C1216($ruleEntity; $customerEntity; $1; $2)

Case of 
	: (Count parameters:C259=2)
		$ruleEntity:=$1
		$customerEntity:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// [Customers];"Entry"
//[AML_AggrRules];"Match"
If ($ruleEntity.thenRequireKYC=Null:C1517)
Else 
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.address; $customerEntity.Address; "Street Address")
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.occupation; $customerEntity.Occupation; "Occupation")
	//[Customers]Occupation
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.countryCode; $customerEntity.CountryOfResidenceCode; "Country of Residence (Country Code)")
	//[Customers]CountryOfResidenceCode
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.citizenship; $customerEntity.CitizenshipCountryCode; "Citizenship (Country Code)")
	//[Customers]CitizenshipCountryCode
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.nationality; $customerEntity.CountryOfBirthCode; "Nationality (Country Code)")
	//[Customers]CountryOfBirthCode
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.PIN; $customerEntity.AML_NatureofBusRelationship; "Purpose & Nature of Bus. Relationship (PIN)")
	// [Customers]AML_NatureofBusRelationship//
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.SIN; $customerEntity.SIN_No; "SIN/SS/ National ID")
	//[Customers]SIN_No
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.phone; $customerEntity.HomeTel; "Main Phone (Landline)")
	//[Customers]HomeTel
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.cell; $customerEntity.CellPhone; "Cell Phone")
	//[Customers]CellPhone
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.pictureID; $customerEntity.PictureID_Number; "Picture ID Number")
	//[Customers]PictureID_Number
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.email; $customerEntity.Email; "Email")
	//[Customers]Email
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.optInEmail; $customerEntity.OptInEmail; "Optin Email")
	//[Customers]optInEmail
	
	checkIf3StateCheckboxValueIs($ruleEntity.thenRequireKYC.optInSMS; $customerEntity.OptinSMS; "Optin SMS")
	//[Customers]optInSMS
	
End if 
