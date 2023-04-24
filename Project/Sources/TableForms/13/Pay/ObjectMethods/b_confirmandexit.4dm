checkInit
checkIfNullString(->[eWires:13]BeneficiaryFullName:5; "Beneficiary Full Name")
checkIfStringLengthIsGT(->[eWires:13]BeneficiaryFullName:5; 4; True:C214; "Beneficiary Full Name")

checkIfNullString(->[eWires:13]BeneficiaryRelationship:64; "Relationship with sender"; "WARN")
//checkIfNullString (->[eWires]BeneficiaryFullName;"Beneficiary Full Name")
//checkIfNullString (->[eWires]BeneficiaryFullName;"Beneficiary Full Name")
//checkIfNullString (->[eWires]BeneficiaryFullName;"Beneficiary Full Name")


If (isValidationConfirmed)
	
	sl_handleEWiresScreening(sl_eWirePerson+sl_ForNextButton)
	//handleCheckeWireBeneficiary("full_next")
	FORM NEXT PAGE:C248
Else 
	BEEP:C151
	myAlert("Please select or enter a beneficiary first")
End if 