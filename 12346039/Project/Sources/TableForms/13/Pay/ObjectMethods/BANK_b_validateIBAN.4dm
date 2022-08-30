C_TEXT:C284($errorCode; $checkSum; $country; $state; $address; $check; $fulladdress; $city)

If ([eWires:13]BeneficiaryBankAccountNo:66#"")
	validateIBAN([eWires:13]BeneficiaryBankAccountNo:66; ->$errorCode; ->[eWires:13]BeneficiaryBankName:76; ->$country; ->$state; ->$address; ->[eWires:13]BeneficiarySWIFT:105; ->$checkSum)
	If ($errorCode#"")
		myAlert("Error Code"+$errorCode)
	Else 
		$fulladdress:=env_makeAddressText($address; $city; $state; ""; $country)
		[eWires:13]BeneficiaryBankDetails:38:=$fulladdress
		
	End if 
Else 
	myAlert("Please enter an IBAN to check. E.g. (FR8630004003200001019471670)")
End if 
